# bootstrap-colours
CSS for Bootstrap V4 Colours

## How to use it

There is a sub-dir called [version]/css

It contains [version]/css/bootstrap_colours.css which contains all 200 or so colours.

Or there is [version]/css/teal.css which just contains teal.

Include the CSS in your project after including the main Bootstrap CSS

```
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-beta.2/css/bootstrap.min.css" integrity="sha384-PsH8R72JQ3SOdhVi3uxftmaW6Vc51MKb0q5P2rRUpPvrszuE4W1povHYgTpBfshb" crossorigin="anonymous">
<link rel="stylesheet" href="4.0.0-beta.2/css/teal.css" >
```

or

```
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-beta.2/css/bootstrap.min.css" integrity="sha384-PsH8R72JQ3SOdhVi3uxftmaW6Vc51MKb0q5P2rRUpPvrszuE4W1povHYgTpBfshb" crossorigin="anonymous">
<link rel="stylesheet" href="4.0.0-beta.2/css/bootstrap_colours.css.css" >
```

Then you can use them

```
<table class="table">
  <tr>
        <td> <button class="btn btn-teal"> btn-teal </button></td>
        <td> <button class="btn btn-outline-teal"> btn-outline-teal </button> </td>
        <td> <span class="text-teal"> text-teal</span> </td>
        <td> <span class="badge badge-teal"> badge-teal</span> </td>
        <td class="bg-teal"> bg-teal</td>
    </tr>
 </table>
```

# The Colours

There are 3 groups of colours

- the W3C list of named colours
- the bootstrap colours, e.g. `.text-gray-100`
- a few brand colours, e.g. `.text-facebook-amazon`

The complete list is in (colours.yaml)[colours.yaml]

You can see the colours (and their class names) in action (here}[https://www.walkingclub.org.uk/test/colours.html]
