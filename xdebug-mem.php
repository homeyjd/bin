#!/bin/php
<?php
/**
 * Analyzes the output of an XDebug script trace
 *
 * The original version can be found here:
 * http://svn.xdebug.org/cgi-bin/viewvc.cgi/xdebug/trunk/contrib/tracefile-analyser.php?root=xdebug
 *
 */
 
if ( $argc <= 1 || $argc > 4 )
{
  showUsage();
}

$fileName = $argv[1];
$sortKey  = 'memory-inclusive';
$elements = 25;
if ( $argc > 2 )
{
	$sortKey = $argv[2];
	if ( !in_array( $sortKey, array( 'calls', 'time-inclusive', 'memory-inclusive', 'time-own', 'memory-own' ) ) )
	{
		showUsage();
	}
}
if ( $argc > 3 )
{
	$elements = (int) $argv[3];
}

ini_set('memory_limit', '100M');

$o = new drXdebugTraceFileParser();
$o->parse($fileName);
$functions =& $o->getFunctions( $sortKey );

// find longest function name
$maxLen = 10;
foreach( $functions as $name => $f )
{
	if ( strlen( $name ) > $maxLen )
	{
		$maxLen = strlen( $name );
	}
}

echo "Showing the {$elements} most costly calls sorted by '{$sortKey}'.\n\n";

echo "        ", str_repeat( ' ', $maxLen - 8 ), "       | Inclusive        | Own              \n";
echo "function", str_repeat( ' ', $maxLen - 8 ), "#calls |   time    memory |   time    memory \n";
echo "--------", str_repeat( '-', $maxLen - 8 ), "---------------------------------------------\n";

// display functions
$c = 0;
foreach( $functions as $name => $f )
{
	$c++;
	if ( $c > $elements )
	{
		break;
	}
	
	printf( "%-{$maxLen}s %6d   %5.3f %8.1fK   %5.3f %8.1fK\n",
		$name, $f['calls'],
		$f['time-inclusive'], $f['memory-inclusive']/1024,
		$f['time-own'], $f['memory-own']/1024 );
}

function showUsage()
{
	echo " Usage:\n\tphp ".basename(__FILE__)." ./tracefile [sortkey] [num_elements]\n\n",
	     " Allowed sortkeys:\n\tcalls, time-inclusive, memory-inclusive, time-own, memory-own\n";
	die();
}

class drXdebugTraceFileParser
{
	/**
	 * Stores the last function, time and memory for the entry point per
	 * stack depth. int=>array(string, float, int).
	 * @var array
	 */
	protected $stack;

	/**
	 * Stores per function the total time and memory increases and calls
	 * string=>array(float, int, int)
	 * @var array
	 */
	protected $functions;

	/**
	 * Stores which functions are on the stack
	 * @var array
	 */
	protected $stackFunctions;

	public function __construct()
	{
		$this->stack[-1] = array( '', 0, 0, 0, 0 );
		$this->stack[ 0] = array( '', 0, 0, 0, 0 );
		$this->stackFunctions = array();
	}

	public function parse($fileName)
	{
		$handle = fopen( $fileName, 'r' );
		if ( !$handle )
		{
			throw new Exception( "Can't open '$fileName'" );
		}
		
		$header1 = fgets( $handle ); // Version:
		$header2 = fgets( $handle ); // File format:
		$header3 = fgets( $handle ); // TRACE
		if ( !preg_match( '@Version: 2.*@', $header1 ) || !preg_match( '@File format: 2@', $header2 ) )
		{
			echo "\nThis file is not an Xdebug trace file made with format option '1'.\n";
			showUsage();
		}
		
		$c = 0;
		$size = fstat( $handle );
		$size = $size['size'];
		$read = 0;
		$lastBuffer = false;
		$startTime = microtime(true);
		
		printf("Parsing %.0f KB...\n", $size/1024);
		
		while ( !feof( $handle ) )
		{
			/**
			$buffer = fgets( $handle, 4096 );
			$read += strlen( $buffer );
			$this->parseLine( $buffer );
			$c++;

			if ( $c % 25000 === 0 )
			{
				printf( " (%5.2f%%)     memory: %.2fKB \n", ( $read / $size ) * 100, memory_get_usage()/1024 );
			}
			
			/**/
			
			$buffer = fread( $handle, 4096 * 1024 );
			if ($buffer === false) break;
			
			$read += strlen( $buffer );
			
			if ($lastBuffer !== false) {
				$buffer = $lastBuffer . $buffer;
				$lastBuffer = false;
			}
			
			$buffer = explode("\n", $buffer);
			$bufferSize = count($buffer);
			$bufferEnd = $bufferSize -1;
			$i = 0;
			
			while ($i < $bufferEnd)
			{
				$cur = & $buffer[$i];
				if ($cur) 
				{
					$this->parseLine( $cur );//trim($cur," \n\r\0\x0B") );
				}
				$i++;
			}
			$cur = null;
			if ($bufferSize && $buffer[$i]) {
				$lastBuffer = $buffer[$i];
			}
			
			printf( " (%5.2f%%)    read: %.0fk  mem: %.0fk \n", ( $read / $size ) * 100, $read/1024, memory_get_usage()/1024 );
			
			/**/
			
			$buffer = null;
			
			
		}
		printf(" Done (%sKB in %.2f sec with peak_mem %.2fKB).\n\n", number_format($size /1024, 2), microtime(true)-$startTime, memory_get_peak_usage()/1024);
	}

	private function parseLine( $line )
	{
	/*
		if ( preg_match( '@^Version: (.*)@', $line, $matches ) )
		{
		}
		else if ( preg_match( '@^File format: (.*)@', $line, $matches ) )
		{
		}
		else if ( preg_match( '@^TRACE.*@', $line, $matches ) )
		{
		}
		else // assume a normal line
		*/
		{
			$parts = explode( "\t", $line );
			if ( count( $parts ) < 5 )
			{
				return false;
			}
			
			$depth = $parts[0];
			$funcNr = $parts[1];
			$time = $parts[3];
			$memory = $parts[4];
			if ( $parts[2] == '0' ) // function entry
			{
				$funcName = $parts[5];
				$intFunc = $parts[6];

				$this->stack[$depth] = array( $funcName, $time, $memory, 0, 0 );

				array_push( $this->stackFunctions, $funcName );
			}
			else if ( $parts[2] == '1' ) // function exit
			{
				list( $funcName, $prevTime, $prevMem, $nestedTime, $nestedMemory ) = $this->stack[$depth];

				// collapse data onto functions array
				$dTime   = $time   - $prevTime;
				$dMemory = $memory - $prevMem;

				$this->stack[$depth - 1][3] += $dTime;
				$this->stack[$depth - 1][4] += $dMemory;

				array_pop( $this->stackFunctions );

				$this->addToFunction( $funcName, $dTime, $dMemory, $nestedTime, $nestedMemory );
			}
		}
	}

	protected function addToFunction( $function, $time, $memory, $nestedTime, $nestedMemory )
	{
		if ( !isset( $this->functions[$function] ) )
		{
			$this->functions[$function] = array( 0, 0, 0, 0, 0 );
		}

		$elem = &$this->functions[$function];
		$elem[0]++;
		if ( !in_array( $function, $this->stackFunctions ) ) {
			$elem[1] += $time;
			$elem[2] += $memory;
			$elem[3] += $nestedTime;
			$elem[4] += $nestedMemory;
		}
	}

	public function & getFunctions( $sortKey = null )
	{
		$result = array();
		foreach ( $this->functions as $name => $function )
		{
			$result[$name] = array(
				'calls'                 => $function[0],
				'time-inclusive'        => $function[1],
				'memory-inclusive'      => $function[2],
				'time-children'         => $function[3],
				'memory-children'       => $function[4],
				'time-own'              => $function[1] - $function[3],
				'memory-own'            => $function[2] - $function[4]
			);
		}

		if ( $sortKey !== null )
		{
			uasort( $result, 
				function( $a, $b ) use ( $sortKey )
				{
					return ( $a[$sortKey] > $b[$sortKey] ) ? -1 : ( $a[$sortKey] < $b[$sortKey] ? 1 : 0 );
				}
			);
		}

		return $result;
	}
}
