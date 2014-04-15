#!/usr/bin/env php
<?php

if (empty($argv)) {
    echo " Usage: ".basename(__FILE__)." path_to_analyze\n";
    echo "   Recursively walks the directory to find all defined classes and interfaces.\n";
    exit(1);
}

$path = realpath($argv[0]);
if ($path && basename($path) === basename(__FILE__)) {
    array_shift($argv);
}

$memstat = function() {
    return sprintf('{ mem:%.1fM pk:%.1fM trupk:%.1fM }', 
	memory_get_usage()/1024/1024,
	memory_get_peak_usage()/1024/1024,
	memory_get_peak_usage(true)/1024/1024
    );
};

// This will tell us if there are any duplicate class names. 
// If not, we can place them in the same directory without conflict.

error_log('Starting at '.$memstat());

// for every file found
$map = array();
$dir = empty($argv[0]) ? '.' : $argv[0];
$dirs = array($dir);
while ($d = glob($dir . '/*', GLOB_ONLYDIR)) {
    $dir .= '/*';
    $dirs = array_merge($dirs,$d);
}
$files = array();
foreach ($dirs as $d) {
    $files = array_merge( $files, glob($d.'/*.php') );
}

$do = function($path) use (&$map) {
    $dbDirPath = 'classes/db/';
    $commonDirPath = 'html/common/';
    $classesDirPath = 'classes/';

    $classDefs = get_declared_classes();
    $funcDefs = get_defined_functions();
    $intDefs = get_declared_interfaces();
    
    // include it
    require_once($path);
    
    // check which classes existed in the file
    $classDefs = array_diff(get_declared_classes(), $classDefs);
    $funcDefs = array_diff(get_defined_functions(), $funcDefs);
    $intDefs = array_diff(get_declared_interfaces(), $intDefs);
    
    // save to map
    $map[$path] = array_merge($classDefs, $funcDefs, $intDefs);
};

$do = function($path) use (&$map) {
    $str = file_get_contents($path);
    $arr = array();
    // find classes
    preg_match_all('#\\b(?:class|interface)\\s+([a-zA-Z0-9_]+)(?:\\s+(?:extends|implements)\\s+([A-Za-z0-9_, ]+))*\\s*{#si', $str, $matches, PREG_SET_ORDER);
    if (empty($matches)) {
    	$arr['error'] = 'no classes found';
    } else {
	    $arr['classes'] = $matches;
	}
	// find functions
	preg_match_all('#\\bfunction[\\t ]+([a-zA-Z0-9_]+)\\s+\\(#i', $str, $matches, PREG_SET_ORDER);
	if (!empty($matches)) {
		$matches = array_map(function($m) { return $m[1]; }, $matches);
		$arr['functions'] = $matches;
	}
	$map[$path] = $arr;
};

error_log("Found ".count($files)." files");
foreach ($files as $f) {
    //echo "\rProcessing '$f'             ";
    $do($f);
}

$classMap = array();
foreach ($map as $file => $res) {
	if (empty($res['classes'])) {
		continue;
	}
	foreach ($res['classes'] as $cur) {
		if (!empty($classMap[$cur[0]])) {
			$map[$file]['error'] = "duplicate classname '$cur[0]' previously found in '{$classMap[$cur[0]]}'";
		} else {
			$classMap[$cur[0]] = $file;
		}
	}
}

error_log("Ending at ".$memstat());

if (defined('JSON_UNESCAPED_SLASHES')) {
	$str = json_encode($map, JSON_UNESCAPED_SLASHES);
} else {
	$str = str_replace('\\/', '/', json_encode($map));
}

echo $str;

