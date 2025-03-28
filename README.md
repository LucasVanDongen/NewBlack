# NewBlack SpaceX Demo Project
## Goals

* Implement all requirements from the document
* Try out my current Module structure in a brand new project to get a benchmark of how much friction it generates while implementing in greenfields projects
* Experimenting with LLM generated code that has deterministic outcomes, as opposed to "Vibe Coding"
* Land a good offer

## Methodology
I will share the methodology of developing this app with you, so you get an idea what steps I was taking to get to this end result.
### Growing the Instructions Document
The base of my approach is a markdown document that I kept expanding with decisions, data types and coding instructions and the work progressed. Because many times you need a fresh prompt to get rid of accumulated hallucinations, fix the lack of context space or clear other noise. But you will also lose the _useful_ context. Pasting all relevant information and decisions back into a document that you feed the LLM every time you start a new prompt will bridge those separate chats.
### Architecture
I've fed the requirements document to Claude and started discussing what approach would be best, and what data it needed. My version of Claude still couldn't visit the API documentation itself, so I was feeding it the information I've found on the GitHub repo of the API. It summarized everything and generated data types for me.

#### Model Layer
The next thing I did was discussing the Model layer architecture, and how it would connect to the yet-to-be-built Views. I like the idea of serving cache first, fresh data later for the same View. I went for an approach where URLSession would cache to disk and memory, where the first request served cached if available, fresh when not and when the response was cached, it would kick off a second request from fresh data.

#### Modularization
I also want everything to be abstracted behind protocols, so I would always be able to inject either a real or a mock implementation for testing. I've developed a multiple packages per module approach where all concrete implementations were completely separated from the UI layer. This allowed us to have very fast and stable Previews in the Packages, so building the UI would become this WYSIWYG experience for the developer. See the `CLAUDE.md` document for it's layout.

#### Defining the Moving Parts
I've decided on all of the moving parts, how they would work together, but I didn't do the implementation yet. I just generated data types and protocols, that would be the base of everything I would build. Filling in code immediately slows you down, and generating too much code at once means you're not reading and thus reviewing any of it.

I also had discussions about the main and edge cases, so it would be possible to generate tests off that.

### Building
I've went bottom-up, starting with the individual modules first, not even creating an app project. The Repositories and SharedUI were the base, then I went for Rockets, which was the simplest module between rockets and launches. I started implementing the already defined protocols by writing tests, then implementing against those tests and then writing tests for all untested parts of the code. This works really well because the first set of tests enforces your happy paths and edge cases, while the remaining tests take a look at the code and checks for uncovered code-technical edge cases. I also generate Mocks for all Definitions.

The main issue was Claude having issues with Swift 6 Concurrency. It definitely needs more hand holding here, by giving examples of good patterns of AsyncStream and such. I fixed stuff manually, but not the way I would normally finish them.

### UI in Previews
To develop the UI without having a main app, I use Previews in a specific Previews target of my UI Package. This target is necessary to prevent stuff like `@testable import` and Mocks to leak into the main build of the app. 

It also helps because I only consume Definitions and Mocks, not Implementations. While this app is just vanilla Swift and SwiftUI, most applications rely on large 3rd party dependencies like Realm and Firebase that crater your build times and often break your Previews.

Having built and tested most of your UI in your Package already means that by the time you start integrating into your main App, that often doesn't have working Previews and long change-build-launch-test cycles as the project grows, there's usually very little left to fix.

### Building the Main App
Only after all four modules were done, I started integrating in the main app. I was getting the right data shown immediately, but there definitely were some issues left to be fixed:

* Launchpad and Rocket didn't show in Launches and Launch Details
* Filtering on date was broken
* Scroll peformance wasn't great because of hard work being done one the main thread while scrolling
* The images on the tabs needed some adjustment
* I needed to bridge the RocketCard to the LaunchDetails

While it would be entirely possible in this scenario to just import RocketUI into LaunchUI, when we start getting Assets in all UI Packages (including SharedUI), you cannot do this anymore.


## Challenges While Developing

* __API:__ The regular Launches API doesn't return Rocket and Launchpad data, but the query one does. I've wasted time on Rocket and Launchpad loading logic, while in the end the Launch would contain all of the data
* __Time Constraints:__ The original goal was to completely generate the project from well-defined prompts, instead of fixing some issues manually. This was not possible within the time frame I ended up having
* __Generics:__ A well-known problem is getting SwiftUI Views from one package to another, without resorting to AnyView. I ended up resorting to AnyView for the RocketCard.
* __Swift 6 Concurency:__ Not many people, including LLM's and me, know how to wield it well. It's been quite a while since I've used it extensively as past year I still supported iOS 16. Some decisions taken I've regretted, because advanced mechanisms like "cache first, then refresh" need a different approach (`AsyncChannel`)
* __Clean Up:__ This is pre-clean-up code, there are some parts where I repeat code around my network/repository logic.
* __Hallucinations:__ A problem with unguided LLM's, something I was not able to fix within the time constraints I had. For example the date filtering had issues, that I ended up fixing manually
* __Dumb Mistakes LLM's Make__: It created DateFormatters for every row, cratering scroll performance. I needed to move them out manually. And I think I still didn't fix scroll performance entirely. 

## Conclusion
While I'm always trying to learn something new and challenge myself while doing these kinds of projects, I'm a bit disappointed I couldn't invest more time to get a nice, pure Swift 6 Concurrency solution and have more and better code generated by the LLM. In my experience is that while the initial investments in LLM documentation is a bit more work (but you'll get documentation for free!), in the end you'll spend a lot less work on doing rote programming chores and spend more time on the fun parts.

Perhaps we could go over some of the improvements I have in mind in our next conversation?
