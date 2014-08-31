Pre select jQuery Plugin
------------------------

Pre select options in a select element based on the value of another select element.

```js
$('[data-pre-selector]').preselect({
	select: "pre-selector",
	optionVal: "options"
});
```

##Options

 - select - data attribute name on the select element which points to the name of the other select element.
 - optionVal - data attribute name on the option element which holds the value for the other select element

##Development

```bash
npm install && bower install
```

To open up a local server and watch files

```bash
gulp watch
```


