# AirScope (3rd Place Hacklahoma 2021)
1. [Video Demo](https://youtu.be/Rw2FovISONA)
2. [DevPost Article](https://devpost.com/software/air-scope)

## Inspiration
As children, many of us are inspired to learn about the mysteries of the night sky. Space captures curiosity like little else, and we hope to use that power to have a transformative effect on teaching fundamental concepts in STEM, and fostering more interest in the night sky. Unfortunately, the overwhelming majority of people don't have the resources nor the expertise to buy and maintain a professional telescope to better explore the cosmos, which is where we come in…

## What it does
Air Scope is an app for individuals and organizations across the world to explore space in an intuitive way. On the app, users can either choose to observe an object from a list of curated targets or select any location in the night sky. Then, their request is distributed to one of an arbitrary number of telescopes that could be stationed anywhere in the world. The telescope client automatically optimizes parameters for the object (ie: exposure, zoom, etc), and captures the photo. While the photo is being taken, the user can monitor the status and conditions of their request in real-time. Once the photo is taken, it is then sent to the user in the complete form so they can see a fully processed version themselves without needing expensive equipment or software licenses.

## How we built it
Architecturally, the application is built with a server backend that handles jobs, a client for each of the telescopes connected to the network, and an iOS client where jobs can be assigned and viewed. Vivek's hobby is Astrophotography so he had a lot of the hardware lying around already. The software/code took the vast majority of the time.

We built the app in SwiftUI and UIKit. Asynchronous tasks such as loading data from the server were written using DispatchQueues to make sure the app UI didn't hang while data was being transmitted.

The backend server adds all incoming jobs to a queue and distributes them to the first available telescope in the optimal location given the object’s characteristics (Time, Right Ascension, Declination). This utilizes Redis, to make the queue persistent and easily recoverable in case of failure, as well as Python and FastAPI.

The telescope client is a simple wrapper around the Voyager Astronomical Telescope Control Software API, exposing the necessary functionality to control the telescope.
The robotic telescope itself has been in use for months prior to this, and as a result, required minimal setup.
## Challenges we ran into
We had difficulty displaying the map in the app since we needed to interact with UIKit to access the features we needed (SwiftUI is still a young framework), but there was little to no documentation. This was compounded by the fact that we needed to communicate with the UIKit view to get information about the coordinates in the sky that were being viewed. Eventually, we figured it out by diving into old forum pages.

In order for the communication between the telescope client and server to correct, there needed to be Bi-directional communication between the two. This ruled out using simple GET, and POST requests so we had to use sockets. Data transfer was also difficult because the hardware interface for the telescope was poorly documented and where there was documentation, some it was incorrect.

## Accomplishments that we're proud of
We're really proud of the queue-based system that allows any number of clients and any number of telescopes to be connected to the network. Whenever an app client requests a celestial object or a specific set of coordinates (in right ascension and declination), the server adds the job to the queue. All telescopes are connected bi-directionally through a TCP Socket so as soon as there are pending jobs in the queue, one of the telescopes will claim the job. This will then update the app UI's status. This makes this application very easy to scale to larger scope networks.

## What we learned
On the app front-end, we learned how to make more complex SwiftUI apps that also asynchronously communicated with a server. We also learned how to embed UIKit views into SwiftUI to make up for any functionality the SwiftUI framework doesn't have as of right now.

## What's next for Air Scope
In the future, we seek to make the map interface easier to use, by implementing AR functionality to overlay a map of the sky, specific to a user's current position. The map would also highlight any special points of interest making the night sky easier to understand. The user can then just point their phone up at the sky, using their phone as a viewfinder, to request a custom picture in an easier way. 

Implement some fail-safes (what happens if no telescope matches the optimal parameters? How should we handle failed requests?)
