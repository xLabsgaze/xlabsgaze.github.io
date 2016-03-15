---
title: Table of Javascript Properties
tags: [getting_started]
audience: all
type: page
homepage: false
---

### Table of Javascript properties

The following table is a non-exhaustive list of the JSON structure that maintains all state and configuration data for the xLabs system. 

The entire JSON tree can be viewed in the Options Page of the xLabs Browser Extension, under the Config tab. Since the structure is JSON, we use the term “path” to indicate the name of a particular nested property. 

Since our implementation is backed by a BOOST Property Tree object, it is not possible to write subtrees as a single command; instead, you should only write values to leaf properties. All values will be serialized to strings. 

For boolean properties (such as .enabled), write a “0” value for off and “1” for on. Undocumented paths should be ignored, as manipulating these values may cause unexpected side effects. 

Writes to some paths are ignored or overwritten; others may not be read until the browser is restarted.

| Property path |	Notes
----------------|------------
|state.*	| The state property and all subpaths are intended to include everything about the current state of the system and user.
state.timestamp |	The timestamp when the state was last updated.
state.frameRate |	The rate at which frames are being processed.
state.calibration.confidence |	A scalar value that is correlated with gaze prediction accuracy.
state.trackingSuspended	 | An error flag, indicating that the gaze state could not be updated because we temporarily lost track of necessary facial features.
state.head.*	| The pose of the user’s head as a 6 DOG rigid body.
state.gaze.vector |	The relative eye pose of the user, as a 2D vector.
state.gaze.measured	| The measured gaze focus of the user in screen coordinates.
state.gaze.estimate	| An estimated gaze focus of the user in screen coordinates.
state.image.size	| The resolution of the input image that was used to update the state.
browser.*	 | Properties of the user’s browser, that are relevant to gaze tracking.
browser.screen.* |	Properties of the display device (screen).
browser.canvas.*	 | Properties of the xLabs Canvas element, which we use for drawing graphics on top of whatever page is being displayed.
browser.canvas.paintLearning |	If set to 1, then in learning mode our UI will be drawn on the canvas. Set to 0 to display your own UI instead.
browser.canvas.paintHeadPose	| If set to 1, then in head mode our UI will be drawn on the canvas. Set to 0 to display your own UI instead.
browser.canvas.enabled	| If set to 1, our canvas is displayed. Normally not used by third party code.
browser.canvas.captureMouse	| If set to 1, our canvas will intercept all mouse events and prevent them from reaching the page. This allows us to provide a UI.
browser.canvas.captureKeyboard	| As captureMouse, but for keyboard events.
browser.document.offset.*	| The offset of the document from the origin of the browser window, in pixels.
system.mode	| The mode of the xLabs system. Possible values are “off”, “head”, “learning”, “mouse” and “training”.
frame.stream.* |	Properties of the image stream that xLabs is using as input.
frame.stream.enabled |	Whether the input image stream is enabled. If 0, then no images are received or processed.
frame.stream.preview |	Activates the preview utility built into the xLabs Browser Extension.
frame.stream.width |	The width in pixels of the image stream.
frame.stream.height |	Height in pixels
frame.stream.rate |	The rate in frames per second at which the system is receiving images. It may be processing at a slower rate.
frame.stream.frameRateThrottler.enabled |	If set to 1, processing will be throttled to match the specified target FPS. This is useful to reduce processing load when near realtime results are not needed.
frame.stream.frameRateThrottler.targetFps |	Target FPS for the throttler, described above.
http.*	 | Not used in Browser Extension API. The HTTP variant of the software uses this.
truth.*	| Truth data is where we think the user was looking at particular times. Used for calibration. CSV format.
watch.*	| Watch data is a CSV file containing measurements of the user’s face at particular times. Associated with truth data to enable calibration.
pipeline.*	| The processing pipeline. Of interest because specific modules can be enabled or disabled.
pipeline.tracking.enabled |	Enables tracking of the user’s face.
pipeline.pinpoint.enabled	| Enables high-precision feature localization on the face (higher CPU workload).
pipeline.validation.enabled	| Enables validation of the face region image quality.
calibration.*	 | The calibration process.
calibration.status	| If zero, there is no good calibration. Else, there is a valid calibration dataset.
calibration.clear	| Any write to this value will cause calibration data to be permanently deleted.
calibration.active	| Value is 1 when calibration is executing, zero otherwise.
calibration.completed	| Value is set, after calibration completion, to the value passed to calibration.request when calibration began.
calibration.request	| Set a value to trigger calibration. The value will be copied to calibration.completed when it’s done.
validation.*	| Validation of the image image – results.
validation.lastFrameTimestamp |	Timestamp of the last time a frame was processed. Indicative of camera issues.
validation.valid |	An overall assessment of the image quality, but may be too strict for many purposes.
validation.errors	| An empty string indicates an absence of errors. Else, the string contains some of the following letters: D (too dark),B (too bright),U (unevenly illuminated), R (low resolution on face), F (frame rate too low).
validation.facePosition |	A rectangle bounding the face region of the user in the image, in pixels, as x, y, w, h. e.g. “261,150,132,111”
algorithm.*	| Properties of the algorithm. Probably best not to touch.
mouseEmulator.*	| Properties of the mouse emulator mode.
gaze.*	 | Gaze is one of 4 logs maintained by the system. Each log is a CSV file with several properties. The CSV data cannot be directly obtained from the config structure. Instead, follow the steps outlined in the logging example code. Note that there are x and x.temp logs; the former are persistent. We only keep persistent logs for truth and watch; the other logs are all transient.
gaze.temp.enabled |	Enables the transient log of gaze data. All gaze estimates will be logged.
gaze.temp.clear |	Clears the transient log of gaze data.
gaze.temp.id	| Set this path with the ID of a HTML element. The xLabs Browser Extension will then populate the element with the content of the transient CSV log file.
error.temp.*	| Another log – see gaze.temp. A log of errors reported by the xLabs system.
click.temp.*	| Another log – see gaze.temp. Values are screen x, y click coordinates, and a timestamp.
scroll.temp.*	 | Another log – see gaze.temp. Values are document x,y scroll offsets and timestamp.
debug.*	| Used to implement the debug UI in the Browser Ex

Please contact us for an explanation of any other property, if required. The omitted properties are generally beyond the scope of this document.