---
title: Syntax and Commands
tags: [getting_started]
audience: all
type: page
homepage: false
---

## JavaScript Syntax and Commands

Having outlined how to interact with the xLabs API in earlier sections, this section is an exhaustive reference to the API functions and properties.

The xLabs API is provided by the xlabs.js file, which can be found at:

~~~javascript
XLABS_HOME/api/xlabs.js
~~~
Once this javascript file is included in your code, you can calls functions using the xLabs prefix, e.g.:

~~~javascript
xLabs.setConfig( PATH, VALUE );
~~~
Note the uppercase ‘L’. The following table lists all the commands supported by the API:

Function 			| Arguments |	Notes
-----------------|-----------|----------
extensionVersion | 	- 		  |	Returns the current extension version as a string, or null if extension is not installed.
setup |	READY, STATE, IDPATH, TOKEN |	Must be called prior to document load. Pass up to 3 callback functions to receive notification of relevant events, and your developer ID if not working on a licenced domain.
isApiReady |	-	| Returns true if the API is ready, false otherwise.
getConfig	| PATH	 | Returns as a string the value of the specified property-PATH.
setConfig	| PATH, VALUE |	Set the specified property PATH to the given VALUE. Will be converted to a string.
resetCalibrationTruth |	-	| Stops interpolation of calibration ground-truth values.
updateCalibrationTruth	| SCREEN_X, SCREEN_Y |	Update interpolation of calibration truth values to current time @ given coordinates.
addCalibrationTruth | TIME_1, TIME_2, SCREEN_X, SCREEN_Y |	Explicitly add a calibration ground truth sample between TIME_1 and TIME_2 (in milliseconds since epoch) @ screen coordinates given.
calibrate	| ID	| Manually request a calibration. The ID is optional, but can be used to identify that a specific calibration request has been executed (e.g. if we want to check whether certain calibration truth has been included in the model). The ID of the completed calibration is set in the property “calibration.completed”.
getTimestamp |	-	| Returns a timestamp, for the current time, in the format required by the xLabs API.
getDpi	| -	 | Returns the estimated/calculated DPI of the user’s screen. Useful when making graphics have a fixed physical size regardless of display pixel dimension.
documentOffset |	-	| Returns the x,y coordinate offset of the document from the browser window. Only works when documentOffsetReady() returns true. It needs a mouse move event to calculate the offset.
documentOffsetReady	| - |	Returns true when the document offset is known, due to prior receipt of a mouse move event.
scr2docX	| SCREEN_X	| Converts the given screen x coordinate into a document relative coordinate.
scr2docY	| SCREEN_Y	| Converts the given screen y coordinate into a document relative coordinate.
scr2doc	| SCREEN_X,SCREEN_Y |	Converts the given screen x,y coordinates into document relative coordinates.
doc2scrX	| DOC_X	| Converts the given document x coordinate into a screen absolute value.
doc2scrY	| DOC_Y	| Converts the given document y coordinate into a screen absolute value.
doc2scr	| DOC_X, DOC_Y |	Converts the given document x,y coordinates into screen absolute values.

