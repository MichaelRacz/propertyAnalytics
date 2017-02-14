import React from 'react';
import ReactDOM from 'react-dom';

var properties = [{description: "property a", rent: 600, squareMetres: 65},
  {description: "property b", rent: 700, squareMetres: 75},
  {description: "property c", rent: 800, squareMetres: 85}];

class Property extends React.Component {
  render() {
    var sectionStyle = { border: "1px dotted", "background-color": "rgb(176, 196, 222)" };
    var displayInline = {display: "inline"};

    return (<section style={sectionStyle}>
        <p>description:<div className="description" style={displayInline}>{this.props.property.description}</div></p>
        <p>rent:<div className="rent" style={displayInline}>{this.props.property.rent}</div></p>
        <p>squareMetres:<div className="squareMetres" style={displayInline}>{this.props.property.squareMetres}</div></p>
      </section>);
  }
};

class PropertyList extends React.Component {
  render() {
    var properties = this.props.properties.map(function(property) {
      return React.createElement(Property, { property: property });
    });
                  
    return (<div>
        <h1>Properties</h1>
        <p>This is a horribly styled list of available properties</p>
        {properties}
      </div>);
  }
};

document.addEventListener("DOMContentLoaded", function(){
  var container = document.querySelector("#container");
  ReactDOM.render(<PropertyList properties={properties}></PropertyList>, container);
});

