# Jekyll Image Set (with Thumbnails)

Create an Image Gallery from a Folder with Image Thumbnails  
Based on [https://github.com/callmeed/jekyll-image-set](https://github.com/callmeed/jekyll-image-set)  
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

## What? 

Takes a subdirectory of the `_uploads` (a collection used by sites made with [siteleaf](https://siteleaf.com)) folder, gets all the images from it, and creates HTML image and container tags **plus** thumbnails with 30% of the full dimensions.

## Installation

Place the image_set.rb file in the _plugins directory of your Jekyll site

Dependency
add this line to your sites Gemfile: `gem "mini_magick"` (with the source: `source 'https://rubygems.org'`)

**not working with github pages**

## Usage

<code>{% image_set uploads/gallery1 %}</code>

(this will create a ul container, then li and img tags for each image in _uploads/gallery1)

## Known Issues

* Tabs/indentation is crappy.
* Images disappear when jekyll build process completes
* Can only choose images from the `_uploads` collection
