## Install dependencies
```
bundle install
```

## Tests
```
rspec
```

## Interactive console
```
ruby run.rb
```
Alternatively
```
chmod +x ./run.rb
./run.rb
```

### Assumptions
- Performance was not a consideration. As it is not clear what are exact performance reqs
performance has been considered not important.
- Styling - it was not clear from the problem description are separate styles gonna be provided
to be used later with generated HTML. Due to that no styling has been done.

### Problem description
The system has many digital images often taken with a camera.
We have exported EXIF data from a selection of these images.
Create a set of static HTML files to allow a user to browse these images.

Create a batch processor that takes the input file and produces a single HTML file (based on the output template given with this test) for each camera make, camera model and also an index.

The index HTML page must contain:
- Thumbnail images for the first 10 work
- Navigation that allows the user to browse to all camera makes

Each Camera Make HTML page must contain:
- Thumbnail images of the first 10 works for that camera make
- Navigation that allows the user to browse to the index page and to all camera models of that make

Each Camera Model HTML page must contain:
- Thumbnail images of all works for that camera make and model
- Navigation that allows the user to browse to the index page and the camera make

The batch processor should take the location of the input file and the output directory as parameters.

The input file only contains a small sample set of works.
