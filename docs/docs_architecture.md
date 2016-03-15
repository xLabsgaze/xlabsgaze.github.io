---
title: Architecture
tags: [getting_started]
audience: all
type: page
homepage: false
---

### Browser Extension

In its current form, our software is provided as a Chrome Browser Extension that must be installed on each user’s computer. 

All processing is performed locally, on the user’s computer. 

The browser extension provides a user interface and manages integration with compatible web pages. To understand the capabilities and limitations of a Browser extension, you may find the [Chrome documentation](https://developer.chrome.com/extensions/getstarted) helpful. We use the HTML5 media & camera interface in the browser to connect to a camera. 

The xLabs software does not connect to the camera except when in a mode that requires image processing. Note that Chrome allows multiple pages and extensions to connect to the same camera simultaneously. 

High-performance image processing is achieved using [Google Native Client](https://developer.chrome.com/native-client), which accepts C and C++ code. The Native Client module is supplied with the browser extension. 

All system state is stored within the Native Client module, which is loaded once per browser process instance (except on extension reload). Therefore, our system is able to continue operating seamlessly through page navigation events. The system configuration is shared by all open tabs. 

At the current time there is no system for managing conflicts between tabs, in the event that multiple tabs interact with the xLabs Browser Extension. Conventionally, the active tab can be assumed to control the xLabs Browser Extension. 

Note: We also offer a native C++ library, with HTTP interfaces, for offline use as an SDK. If you would like to use this library, please [contact us](https://xlabsgaze.com/contact-us/).


### Javascript API interface

We include a Javascript interface to allow web pages to communicate with our Browser Extension. A reference guide to the Javascript interface can be found at the end of this document.  The end-user browser extension includes the functions required by the Javascript interface (i.e. no additional software needs installation to allow development). 

We also provide a Javascript API file called xlabs.js that provides an easy way for embedding pages to generate the messaging necessary to efficiently use the xLabs system. The browser extension’s content-script will accept messages from the embedding web page, allowing the page to modify the state of the Eye/Gaze tracking system. The page can also add listeners to detect specific events – firstly, the presence and setup of the Eye/Gaze tracking system, and secondly, updates to the state of the Eye/Gaze tracking system. The latter are pushed to the page as CustomEvent objects, to reduce the latencies associated with polling. 

Note that the end-user Browser Extension only accepts commands from licenced domains and developers. Licenced developers are identified and authorized via an ID token. Using an ID token allows the existing Browser Extension to accept commands from the local computer, including localhost, file:// and loopback (127.0.0.1) in IPv4 and IPv6. This allows you to experiment and develop software that is compatible with our Browser Extension Javascript API. 

You need to [register](https://xlabsgaze.com/registration/) to receive a developer ID token. The Javascript interface allows embedding web pages to receive the state of the system at up to 20Hz by default. Processing can be throttled back (or higher, on fast computers) to optimize experience and power consumption. Embedding web pages can manipulate the system at high speed (up to 100s of configuration changes per second) but it is best to minimize this load.


### Options Page Config Tab

The Browser Extension includes a webpage designed to help you debug your gaze-enabled pages. It prints a continuously updated list of all the system state available in the Javascript API. 

To visit the debug page, click the ‘X’ to open the Popup Menu and then click the Options button. When the Options Page appears, click the “Config” tab. You will see the current state of the system. If the system is not Off, the state will be updated at 10Hz. To see the state change, use the Popup Menu to set the state to “Head”. Some of the values will change. You can also modify the configuration from the Options page.  
For example, if you enter: Key: `system.mode` Value: `off` … the system will turn off. Full details of the system state are included in the Javascript reference section.