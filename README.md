# FlickrFeeds App

The app searches and displays the Flickr Feeds


## Code Overview

The code is implemented in below layers

- Network Layer (Responsible for making network request)
- Data Access Layer (Responsible for providing data as pages)
- User Interface (Responsible for displaying data)

The app consists of below modules

- Feeds Module (Fetching feeds using the flickr search api and caching the response)
- Image Module (Downloading and caching image for a feed )
- Networking Module (Responsible for making network request)

## Architecture Design Pattern

Protocol Oriented Programming using Generics 
- Resource - Represents a resource that needs to be fetched (Feed or Image).
- PagedRecource - Represents a resource that is fetched in pages. 


## Code Structure

The code is neatly organized in folders/groups depicting different modules


## Testability

- Tests for Data Access Layer
- Tests for Network Layer 
