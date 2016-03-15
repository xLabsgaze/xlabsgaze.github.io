---
title: Quickstart Guide
tags: [getting_started]
audience: all
type: page
homepage: false
---

## QuickStart guide

This quickstart guide is designed to get you up and running as quickly as possible.


### Installing the Browser Extension
You need to install the xLabs Browser Extension to interact with it! You can get the extension [here](https://chrome.google.com/webstore/detail/xlabs-headeyegaze-tracker/emeeadaoegehllidjmmokeaahobondco).

Once installed, you can manage this extension in Chrome by navigating to:
[chrome://extensions](chrome://extensions)

You also need to register as a developer, if you have not already done so - you can register [here](https://xlabsgaze.com/registration/). 

After registration, you will be provided with an ID token that you must use while developing. 

Once you have your ID token, you can make use of the Browser extension in your projects.


### Example code
Many of our examples are hosted on our website, so that you and users can try playing them immediately. However, for your convenience we have also hosted all this code on Github, which enables you to easily download it all to your computer by Cloning the repository. `https://github.com/drawlinson/xlabs-demo`


### Head Tracking
Let’s assume the root path of the Github source code is:
`XLABS_HOME`

All file names will be discussed relative to this location. It’s easiest to start with a simple example that should be easy for Javascript developers to follow. The example is provided as a HTML file in the client software install, named: `XLABS_HOME/head/index.html`.  

The contents of this file are as follows:

~~~html
<h1>xLabs Software Developer Kit: Head tracking</h1>
<p>This page checks for presence of the browser extension and uses head tracking to position an element on screen.</p>
<h3 id="target" style="color: red; margin: 0; padding: 0; position: fixed; left: 200; top: 200; font-size: 48;">X</h3>
<script src="../api/xlabs.js" type="text/javascript"></script>
<script type="text/javascript">

var Demo = {

   update : function() {
     var x = xLabs.getConfig( "state.head.x" );
     var y = xLabs.getConfig( "state.head.y" );
     var targetElement = document.getElementById( "target" );
     targetElement.style.left = ( screen.width * 0.5 ) - ( x * 300 );
     targetElement.style.top = ( screen.height * 0.5 ) + ( y * 300 );
   },

   ready : function() {
     xLabs.setConfig( "system.mode", "head" );
     xLabs.setConfig( "browser.canvas.paintHeadPose", "0" );
   }

 };

 xLabs.setup( Demo.ready, Demo.update, null, "myToken" );
</script>
~~~
Note that the file contains some basic HTML and an inlined Javascript code block. The file has the following functionality:  

* It includes the xlabs.js file, that provides an easy interface to our API.
* It listens for a custom event indicating that the xLabs Javascript API is available and ready.
* It listens for custom events providing updated state information from the xLabs Javascript API.
* It sends commands to the Eye/Gaze tracking system to enable & configure it.
* It displays a red ‘X’ that can be moved by the user’s head.
Now let’s look at how this functionality was achieved.


### Detecting the xLabs API
The Javascript inline code block defines an object named Demo.  

~~~
var Demo = {

   update : function() {
     var x = xLabs.getConfig( "state.head.x" );
     var y = xLabs.getConfig( "state.head.y" );
     var targetElement = document.getElementById( "target" );
     targetElement.style.left = ( screen.width * 0.5 ) - ( x * 300 );
     targetElement.style.top = ( screen.height * 0.5 ) + ( y * 300 );
   },

   ready : function() {
     xLabs.setConfig( "system.mode", "head" );
     xLabs.setConfig( "browser.canvas.paintHeadPose", "0" );
   }

 };
~~~
This object wraps up the state and functions we need for our demo.  
After we have defined the Demo object, the next thing we are going to do is to call xLabs.setup().  

~~~
 xLabs.setup( Demo.ready, Demo.update, null, "myToken" );
~~~
You will need to replace “mytoken” with your actual ID token. The xLabs API will ignore your commands until you have provided a valid ID token.  
In addition to identifying ourselves, the setup function enables the xLabs API on the page, and passes it our event handlers for two events: Ready, and Update (a third event handler, described below, is not used in this example).  

Our Demo object functions will be called when the relevant events are received. The Ready event is sent once, after the page and Browser Extension content script have completed loading.  

The browser extension content-script itself loads after the rest of the page has finished loading, so we know the DOM is complete at this stage. When Demo receives this event, it means that both the page and the Eye/Gaze tracking system are ready for use. The browser extension adds a ‘data-‘ attribute to the root html tag that contains the version of the plugin. The function xLabs.extensionVersion returns the version string or null when it can’t find the attribute. So you can test if the extension is installed like this:

~~~
 if( !xLabs.extensionVersion() ) { alert('extension not installed') }
~~~
If the extension is not installed, xLabs.setup will show an error on the javascript console. You can handle the missing-extension event in any way you wish.
