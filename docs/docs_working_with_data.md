---
title: Working with Data
tags: [getting_started]
audience: all
type: page
homepage: false
---

### Getting and displaying data

The `Demo.update()` function is called repeatedly every time the xLabs API pushes another state update event. 

~~~
update : function() {
     var x = xLabs.getConfig( "state.head.x" );
     var y = xLabs.getConfig( "state.head.y" );
     var targetElement = document.getElementById( "target" );
     targetElement.style.left = ( screen.width * 0.5 ) - ( x * 300 );
     targetElement.style.top = ( screen.height * 0.5 ) + ( y * 300 );
   },

~~~

When this happens, we can use the getConfig function to obtain specific property values.  

The xLabs API maintains a complete copy of the Eye/Gaze tracking system state so it is efficient to ask for many properties separately.  

Here, we ask for the head X and Y coordinates and use these to calculate a new coordinate for our “target” element, based on the centre of the screen, offset by the user’s head movement. 

Next, we modify the CSS style of our “target” element (which contains an “X”) to move it to reflect the head position observed. So, when you load this page, you’ll be able to move the “X” element by moving your head. Note that the Config tab in the Options Page of our Browser Extension shows a complete list of all the properties you can query using this interface.


### Video Preview

For various reasons, developers may want to integrate interfaces with the video stream being used for head, eye and or gaze tracking. The video preview example shows how to do this.  

Essentially, we exploit the fact that Chrome will provide the same video feed to multiple Javascript listeners. 

~~~
XLABS_HOME/preview/index.html
~~~
This demo is different in that we still need to call setup on the Javascript API, but we pass null as the ready and event listener functions. This is perfectly acceptable.  

In this case we only respond to user clicks, so we don’t need to wait for xLabs API events. As before, we create an inline Javascript object called Demo.  
We add some listeners to the click events of buttons that allow the user to control video preview and streaming.  

**What are the differences between preview and streaming?**  
The property `frame.stream.enabled` toggles whether the xLabs image processing module will receive images. This effectively toggles all processing of video.  
The property `frame.stream.preview` is a little more complicated. You need to put a `<video width="300" height="150"></video>`
element into your document with the ID attribute set to “xLabsPreview”.  

When you use the xLabs setConfig API to set `frame.stream.preview` to 1, the xLabs Browser Extension will find this element and set it up to receive a video stream.  

When you use the xLabs API to set `frame.stream.preview` to 0, the Browser Extension will clean up and stop the video stream, releasing all resources.  
It’s easiest to let xLabs manage this as open video streams can consume a lot of memory and battery. Of course, you can place the video element anywhere on the page, and style it as you choose.So, to summarize, this demo shows you how to accomplish two things:

* how to turn on and off video access by xLabs
* how to insert the same video content into your pages.

The snippet of code responsible for all this is shown below:

~~~html
<video id="xLabsPreview" autoplay="autoplay" width="300" height="150"></video>
<script src="../api/xlabs.js" type="text/javascript"></script><script type="text/javascript">

var Demo = {
 cameraStart : function() {
  xLabs.setConfig( "frame.stream.enabled", "1" );
 },
 cameraStop : function() {
  xLabs.setConfig( "frame.stream.enabled", "0" );
 },
 previewStart : function() {
  xLabs.setConfig( "frame.stream.preview", "1" );
 },
 previewStop : function() {
  xLabs.setConfig( "frame.stream.preview", "0" );
 }
};

xLabs.setup( null, null, null, "myToken" ); 

var buttons = document.querySelectorAll( 'button' );
[].forEach.call( buttons, function( button ) {
  button.addEventListener( 'click', function( e ) {
   switch( e.target.id ) {
    case 'camera-start' : Demo.cameraStart(); break;
    case 'camera-stop' : Demo.cameraStop(); break;
    case 'preview-start' : Demo.previewStart(); break;
    case 'preview-stop' : Demo.previewStop(); break;
   }
  } ); // event listener
} ); // call
</script>
~~~
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

