---
title: xLabs and xLabsgaze
tags: [getting_started]
audience: all
type: page
homepage: false
---

## xLabs and xLabsgaze

### Software features

The xLabs Eye/Gaze tracking system is able to continuously calculate where you are looking on a computer screen, while allowing natural freedom of movement. It does not require any special hardware – just any ordinary webcam. 

This gaze data is calculated locally and in realtime (i.e. it is available as soon as it happens). As far as we know, there is no other software-only system with these capabilities. 

The system is free to download and use for non-commercial purposes. The interface is integrated into web browsers (such as Chrome, Safari and Firefox) allowing eye/gaze to be tracked as part of any website or web application.  

We encourage users and developers to build useful tools and programs on top of the system, using our Javascript interface. The eye-gaze tracking system has many features in addition to working out what you’re looking at. 

Many features are inherent to capturing head and face position in 4D. All these features are now available to Javascript developers and can be added to website content and functionality:

**Face detection:** We signal whether a face is present at the user’s computer. No calibration needed.

**Eye-Gaze tracking:** Of course, we provide the focus of user’s gaze on screen (calibration required).

**Face pose:** We continuously provide a 6 DOF rigid pose of the face, so you can respond to movements. No calibration is necessary.

**Fitted face model:** We also output a 76-vertex 3D model of the user’s facial features. (No calibration).

**Head gestures:** You can respond to user head movements as deliberate gestures, providing another control input.

**Eye pose:** In addition to where the user is looking on the screen, we can provide details of raw eye movements, which can reveal mental states e.g. tiredness (without calibration).

**Passive and interactive calibration:** You can calibrate gaze tracking interactively, via custom interfaces, or passively – we can simply watch the user complete other activities and use this data to continuously calibrate. The system is essentially self-learning and self-healing when circumstances change.


### Benefits

Vision is the superhighway into the human brain. The way in which we respond to appearance reveals much about conscious and subconscious mental state. This information is of tremendous value to both users and website or content providers. 

Many applications can be built on this data:

* Track focus of attention for User eXperience (UX) studies, psychology experiments and online training.
* Detect patterns of gaze that indicate enhanced interest, confusion, or frustration, and make the web page respond appropriately.
* Detect when items are not noticed and promote them; alternatively, hide things that are repeatedly ignored.
* Create stunning dynamic interfaces that respond visually to looks, movement and mouse actions.
* Capture sequences of events and interactions between site content – what’s read, what the user does next – and build better, more intuitive interfaces.
* Infer emotional states and reactions. 
* Improve safety by checking alertness. 
* Infer distraction and exhaustion. 
* Know when your content should pause, or shut up, or simplify itself, to ease the burden on the user. 
* Make the site fit into the user’s world – when something takes them away from the screen, stop what’s happening and wait for them to return.


### Our mission: Everything beyond the screen

*Our mission is to capture everything that’s happening in the user’s world, enabling content providers to build more human interfaces.*

*“90% of human communication is nonverbal”*

Researchers believe that the vast majority of natural human communication is accomplished by gestures, gaze, and actions rather than by words. 

One of the frustrating and alien things about computers is that they’re totally insensitive to most of the expressions produced by people. Fixing this will make computer interfaces far more intuitive, responsive and natural – more human. 

Technically, we can hope to capture the nonverbal parts by watching the user through the low-quality webcams that are now so widely available. (And with a little help from some clever artificial intelligence…). This gives us the architecture of the xLabs Eye/Gaze tracking system.
