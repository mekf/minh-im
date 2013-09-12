{{{
    "title"    : "Gotcha! CoffeeScript Implicit Return ... Or Not",
    "tags"     : [ "node", "express", "coffeescript", "javascript", "gotcha", "tips n' tricks" ],
    "category" : "development",
    "date"     : "9-12-2013"

}}}

I had been trying following this [tutorial](http://net.tutsplus.com/tutorials/javascript-ajax/build-a-complete-mvc-web-site-with-expressjs/) on Nettus+ where Krasimir Tsonev demonstrated the process of building a CRUD app on Node.JS and Express. Because I thought that I'd learn better if I applied my tweaks onto it, I restructured the app based on that of Rails and converted his JavaScript codes into CoffeeScript. Everything went on quite smoothly until I could not get the specs of the base model to pass with my CoffeeScript version. That was when I discovered the caveat of CoffeeScript implicit return.

<!--more-->

#### Base Model Spec  
`base.model.spec.js`
```javascript
var Model = require("../../app/models/Base"),
    dbMockup = {};
describe("Models", function() {
    it("should create a new model", function(next) {
        var model = new Model(dbMockup);
        expect(model.db).toBeDefined();
        expect(model.extend).toBeDefined();
        next();
    });
    it("should be extendable", function(next) {
        var model = new Model(dbMockup);
        var OtherTypeOfModel = model.extend({
            myCustomModelMethod: function() { }
        });
        var model2 = new OtherTypeOfModel(dbMockup);
        expect(model2.db).toBeDefined();
        expect(model2.myCustomModelMethod).toBeDefined();
        next();
    })
});
```

&nbsp;  
`base.model.spec.coffee`
```coffeescript
Model = require('../../app/models/Base')
dbMockup = {}
describe 'Models', ->
  it 'should create a new model', (next) ->
    model = new Model(dbMockup)
    expect(model.db).toBeDefined()
    expect(model.extend).toBeDefined()
    next()

  it 'should be extendable', (next) ->
    model = new Model(dbMockup)
    OtherTypeOfModel = model.extend
      myCustomModelMethod: ->
    model2 = new OtherTypeOfModel(dbMockup)
    expect(model2.db).toBeDefined()
    expect(model2.myCustomModelMethod).toBeDefined()
    next()
```

&nbsp;  
#### Base Model
`Base.js`
```javascript
module.exports = function(db) {
    this.db = db;
};
module.exports.prototype = {
    extend: function(properties) {
        var Child = module.exports;
        Child.prototype = module.exports.prototype;
        for(var key in properties) {
            Child.prototype[key] = properties[key];
        }
        return Child;
    },
    setDB: function(db) {
        this.db = db;
    },
    collection: function() {
        if(this._collection) return this._collection;
        return this._collection = this.db.collection('fastdelivery-content');
    }
}
```

&nbsp;  
`Base.coffee`
```coffeescript
module.exports = (db) ->
  @db = db

module.exports:: =
  extend: (properties) ->
    Child = module.exports
    Child:: = module.exports::
    for key of properties
      Child::[key] = properties[key]
    Child
  setDB: (db) ->
    @db = db
  collection: ->
    return @_collection  if @_collection
    @_collection = @db.collection('fastdelivery-content')
```

&nbsp;  
At first glance, the CoffeeScript versions were straight ports from JavaScript and up until that moment I had been practising the these conversions without hiccup. Definetly something went wrong and I didn't know where it was so I tried mix-matching the JS and Coffee versions and the specs only failed if I used my Coffee version of the model. In the specs, I expected a new instance of the model to be created however the backtrace indicated the error `Expected undefined to be defined.`. Suddenly, I realised where my mistake was. The error was clear enough therefore had I understood JS and CoffeeScript better, I wouldn't have to spend the better part of my time trouble shooting with no target. It should be clear in the compiled JS.  

```javascript
module.exports = function(db) {
  return this.db = db;
};

module.exports.prototype = {
  extend: function(properties) {
    var Child, key;
    Child = module.exports;
    Child.prototype = module.exports.prototype;
    for (key in properties) {
      Child.prototype[key] = properties[key];
    }
    return Child;
  },
  setDB: function(db) {
    return this.db = db;
  },
  collection: function() {
    if (this._collection) {
      return this._collection;
    }
    return this._collection = this.db.collection('fastdelivery-content');
  }
};
```

&nbsp;  
CoffeeScript functions will automatically return their final values, even without using the `return` keyword. For a while it seemed a little weird, but as I didn't run into any issue with my simple codes I consistenly forgot about it. I assumed that this is a good practise for two reasons. First, the last thing a function processes should be the best it can return, or at least as good as `undefined`. Second, it means I can always assume that a function returns something. In this situation, I gave my spec a blank db `Object` and due to some reasons that I hadn't completely understood, the model returned an `undefined` value. It should be no brainer that something which is `undefined` cannot be expected `toBeDefined()`. In order to tell CoffeeScript to not return something explicitly, we have to make it so.

```coffeescript
module.exports = (db) ->
  @db = db
  null
  # true
  # return
  # undefined
```

&nbsp;  
#### Lesson Learned
Make sure that you understand what a CoffeeScript function actually returns.

#### References
* [http://stackoverflow.com/questions/7391493/is-there-any-way-to-not-return-something-using-coffeescript](http://stackoverflow.com/questions/7391493/is-there-any-way-to-not-return-something-using-coffeescript)
* [http://programmaticallyspeaking.com/why-i-hate-implicit-return-in-coffeescript.html](http://programmaticallyspeaking.com/why-i-hate-implicit-return-in-coffeescript.html)
* [http://evansolomon.me/notes/lessons-learned-in-coffeescript/](http://evansolomon.me/notes/lessons-learned-in-coffeescript/)