---
title: Calibration and logging
tags: [getting_started]
audience: all
type: page
homepage: false
---

### Gaze Tracking with Passive Calibration
Gaze tracking uses a very similar set of interfaces to head tracking.  

However, gaze tracking is more complex because it requires calibration. You should fully understand the head-tracking example before looking at gaze tracking.  

The easiest way to include gaze tracking with your pages is via “passive” calibration. This is the method used in xLabs’ Learning Mode.  

Basically, whenever the user clicks in the page we assume the user is looking where they clicked. We use this data for calibration. The embedding page doesn’t really need to do anything other than set xLabs to Learning Mode, hide the default graphics, and collect the gaze data.  
This method works really well when:

* Gaze tracking is for informational or augmentation purposes, not essential to normal use
* it is not necessary for it to be working immediately
* it doesn’t have to be guaranteed to work all the time
* the user will spend at least several minutes browsing the gaze-enabled part of your website.

The “Ants” demo shows an example of this. This demo requires the user to squash ants by clicking on them as they crawl all over the page.  
After a while, as gaze tracking calibrates, the ants start getting squashed simply by looking at them.  

~~~
XLABS_HOME/ants/index.html 
XLABS_HOME/ants/ants.js
~~~ 

We’ll pull a few lines out of the ants source code to show interaction with the xLabs system. The rest of the code is mostly rendering and generating ants! As before, we need to call setup() on the xLabs API and pass our callback functions and token to it.  
When our API ready callback is called, we set `system.mode` to “learning” and `browser.canvas.paintLearning` to “0”, which disables the default painting routines:

~~~
   function onXlabsReady() {
    xLabs.setConfig( "system.mode", "learning" );
    xLabs.setConfig( "browser.canvas.paintLearning", "0" );

    ants = new XLabsAnts();
    ants.init( function() {
    document.addEventListener( "click", function(e) { ants.onClick(e); } );
      ants.mainLoop();
    });
  }

  function onXlabsUpdate() {
    ants.updateGaze();
  }

  xLabs.setup( onXlabsReady, onXlabsUpdate, null, "myToken" );
~~~  
  
To be nice we will also turn off xLabs when the user navigates away from the page, so they don’t have to turn it off themselves:

~~~
   window.addEventListener( "beforeunload", function() {
    xLabs.setConfig( "system.mode", "off" );
  });
~~~  

In Learning Mode xLabs will handle calibration automatically when the user clicks. So now let’s incorporate gaze data into the page. We get the gaze data using the `xLabs.getConfig` function:

~~~
var xs = parseFloat( xLabs.getConfig( "state.gaze.estimate.x" ) ); // screen coords
  var ys = parseFloat( xLabs.getConfig( "state.gaze.estimate.y" ) );
~~~  
Some further complexity is introduced by the fact that gaze coordinates are given relative to the screen, not the browser window.   
Javascript coordinates for page elements are described relative to the client area of the browser window. 

Fortunately, mouse-move events come with screen coordinates, and xLabs can use the mouse-move events to discover the relationship between client-area and screen coordinates.  
However, it is impossible to discover this transformation until the user has moved the mouse.

~~~
   if( !xLabs.documentOffsetReady() ) {
    return;
  }
~~~  
The `xLabs.documentOffsetReady()` method tells us whether we can use the xLabs API to convert screen to document coordinates. If it’s not ready, we can’t use the gaze coordinates.  

We can then ask xLabs to convert these values from screen to document coordinates, to see if they squish any ants:

~~~
  var x = xLabs.scr2docX( xs );
  var y = xLabs.scr2docY( ys );
~~~  

That’s essentially it. We turned on automatic, passive calibration; we got gaze data; we converted it to document coordinates, and we used it for our game.  
You might also want to handle some errors, and take note of whether the system has calibrated itself yet. The most common error is “tracking suspended”, and we can also check “calibration status”:

~~~
  var trackingSuspended = parseInt( xLabs.getConfig( "state.trackingSuspended" ) );
  var calibrationStatus = parseInt( xLabs.getConfig( "calibration.status" ) );

  if( ( calibrationStatus == 0 ) || ( trackingSuspended == 1 ) ) {
    return;
  }
~~~  
If these properties are good, we can continue and look at the “confidence” of the gaze system. Typically, values < 8 indicate good confidence:

~~~
   var c = parseFloat( xLabs.getConfig( "state.calibration.confidence" ) );
~~~   
If these conditions are not met, you probably don’t want to use the gaze data.

 
### Gaze Tracking with Interactive Calibration

Interactive calibration is significantly more complicated because developers need to manage the entire interface. Your pages also need to tell xLabs that the user is looking at a particular screen coordinate, at a specific time interval. 

We call this data [ground-] “truth”. Your interfaces should also interact with the user to ensure they’re seated in a good position, in view of the camera, and check that the image quality is good. 

Since you’re not able to use the passive calibration mode, we assume it’s really important that it works every time, for every user, so these precautions are warranted. One interactive calibration demos is provided:

~~~
XLABS_HOME/balloons
~~~
Most interactive calibration systems will have the same interactions with the xLabs API. First, you need to setup xLabs as normal, with your callback functions:

~~~
   xLabs.setup( Guide.onXlabsReady, Guide.onXlabsState, null, "myToken" );
~~~   
When xLabs is ready, you need to set the mode to “training”. This is the “page defined” mode, from the user’s perspective.

~~~
   xLabs.setConfig( "system.mode", "training" );
~~~   
Next, you need to start sending calibration truth data when users are looking at specific points on screen:

~~~
   xLabs.updateCalibrationTruth( xs, ys );
~~~   
Note that these must be screen coordinates, not document ones. Of course, you can use the xLabs API to convert them for you. xLabs will interpolate between each `updateCalibrationTruth` point until you tell it that the user has stopped looking (or, we simply don’t know where they are looking). 

When this happens, you need to call:

~~~
   xLabs.resetCalibrationTruth();
~~~
   
How do you know when and where the user is looking? Basically you need to design your interaction features to figure this out.  

Ask the user to watch a moving object, or use clicks, to know when the user is watching a particular location on screen. Finally, when you’ve gathered “enough” data, to calibrate the system you call:

~~~
   xLabs.calibrate();
~~~   
In this mode, xLabs will only calibrate when you request it. 

How do you know when you have enough data? This is tricky, because the quality of the data depends on how much pose variation is included. If the user hasn’t moved, generalization to new poses will be poor.  
The example interfaces provided (donut and guide) both achieve reasonable calibrations – you can use this as a rough guide to how much interaction is necessary, and experiment with your own interfaces.


### Logging Data

The final example we will cover shows how to recover bulk data (e.g. logs of gaze coordinates) from the xLabs API.  

To make developers lives easier, and for speed, we can accumulate temporary (short term) logs of gaze, click, scroll, and error data for use in your applications.  
An example of how this would be useful; is if you want to record how users interact with a particular section of a website.  
The logging example can be found in:

~~~
XLABS_HOME/log/index.html
~~~

There are 3 steps to managing logs. 

1. You have to turn specific logs on and off. 
2. You have to send a request for log content. 
3. The xLabs API will populate a specific DOM element with the content of a specific log-file. 

To access logs, when you setup xLabs, you need to register an id-path callback with the API. The term “path” here refers to the property path of the relevant log file.

~~~
 var Demo = {
  ...

  idPath : function( id, path ) {
    if( id == "myLog" ) {
      alert( "DOM updated element "+id+" with xLabs CSV data from "+path );
    }
  },

  ...
};

xLabs.setup( Demo.ready, Demo.update, Demo.idPath );
~~~

Logs can be turned on and off with a `setConfig` command (note you can substitute click, error, gaze and scroll in the sample below):

~~~
   xLabs.setConfig( "click.temp.enabled", "1" );
~~~   
Finally, logs are retrieved by another `setConfig` command specifying the ID of the DOM element you wish to be populated with CSV data from the specified log file.  

In this example, we want click data to be inserted into the HTML element with `id=”myLog”`:

~~~
   xLabs.setConfig( "click.temp.id", "myLog" );
~~~   
When this command is received, xLabs will retrieve the log data and inject it into the page in the element you specified. On completion, xLabs will call your id-path callback so you can handle the data.

