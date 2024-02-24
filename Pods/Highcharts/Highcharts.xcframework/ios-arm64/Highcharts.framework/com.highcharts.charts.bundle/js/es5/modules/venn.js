/*
 Highcharts JS v10.3.3 (2023-01-20)

 (c) 2017-2021 Highsoft AS
 Authors: Jon Arild Nygard

 License: www.highcharts.com/license
*/
(function(a){"object"===typeof module&&module.exports?(a["default"]=a,module.exports=a):"function"===typeof define&&define.amd?define("highcharts/modules/venn",["highcharts"],function(n){a(n);a.Highcharts=n;return a}):a("undefined"!==typeof Highcharts?Highcharts:void 0)})(function(a){function n(a,d,b,z){a.hasOwnProperty(d)||(a[d]=z.apply(null,b),"function"===typeof CustomEvent&&window.dispatchEvent(new CustomEvent("HighchartsModuleLoaded",{detail:{path:d,module:a[d]}})))}a=a?a._modules:{};n(a,"Core/Geometry/GeometryUtilities.js",
[],function(){var a;(function(a){a.getCenterOfPoints=function(a){var b=a.reduce(function(a,b){a.x+=b.x;a.y+=b.y;return a},{x:0,y:0});return{x:b.x/a.length,y:b.y/a.length}};a.getDistanceBetweenPoints=function(a,d){return Math.sqrt(Math.pow(d.x-a.x,2)+Math.pow(d.y-a.y,2))};a.getAngleBetweenPoints=function(a,d){return Math.atan2(d.x-a.x,d.y-a.y)}})(a||(a={}));return a});n(a,"Core/Geometry/CircleUtilities.js",[a["Core/Geometry/GeometryUtilities.js"]],function(a){var d=a.getAngleBetweenPoints,b=a.getCenterOfPoints,
z=a.getDistanceBetweenPoints,m;(function(a){function l(a,f){f=Math.pow(10,f);return Math.round(a*f)/f}function q(a){if(0>=a)throw Error("radius of circle must be a positive number.");return Math.PI*a*a}function h(a,f){return a*a*Math.acos(1-f/a)-(a-f)*Math.sqrt(f*(2*a-f))}function k(a,f){var b=z(a,f),d=a.r,p=f.r,h=[];if(b<d+p&&b>Math.abs(d-p)){d*=d;var r=(d-p*p+b*b)/(2*b);p=Math.sqrt(d-r*r);d=a.x;h=f.x;a=a.y;var k=f.y;f=d+r*(h-d)/b;r=a+r*(k-a)/b;a=p/b*-(k-a);b=p/b*-(h-d);h=[{x:l(f+a,14),y:l(r-b,14)},
{x:l(f-a,14),y:l(r+b,14)}]}return h}function m(a){return a.reduce(function(a,b,d,p){p=p.slice(d+1).reduce(function(a,f,p,h){var l=[d,p+d+1];return a.concat(k(b,f).map(function(a){a.indexes=l;return a}))},[]);return a.concat(p)},[])}function u(a,f){return z(a,f)<=f.r+1e-10}function x(a,f){return!f.some(function(f){return!u(a,f)})}function n(a){return m(a).filter(function(f){return x(f,a)})}a.round=l;a.getAreaOfCircle=q;a.getCircularSegmentArea=h;a.getOverlapBetweenCircles=function(a,f,b){var d=0;b<
a+f&&(b<=Math.abs(f-a)?d=q(a<f?a:f):(d=(a*a-f*f+b*b)/(2*b),b-=d,d=h(a,a-d)+h(f,f-b)),d=l(d,14));return d};a.getCircleCircleIntersection=k;a.getCirclesIntersectionPoints=m;a.isCircle1CompletelyOverlappingCircle2=function(a,b){return z(a,b)+b.r<a.r+1e-10};a.isPointInsideCircle=u;a.isPointInsideAllCircles=x;a.isPointOutsideAllCircles=function(a,b){return!b.some(function(b){return u(a,b)})};a.getCirclesIntersectionPolygon=n;a.getAreaOfIntersectionBetweenCircles=function(a){var f=n(a);if(1<f.length){var h=
b(f);f=f.map(function(a){a.angle=d(h,a);return a}).sort(function(a,b){return b.angle-a.angle});var l=f[f.length-1];f=f.reduce(function(f,h){var l=f.startPoint,k=b([l,h]),m=h.indexes.filter(function(a){return-1<l.indexes.indexOf(a)}).reduce(function(v,g){g=a[g];var c=d(g,h),e=d(g,l);c=e-(e-c+(e<c?2*Math.PI:0))/2;c=z(k,{x:g.x+g.r*Math.sin(c),y:g.y+g.r*Math.cos(c)});g=g.r;c>2*g&&(c=2*g);if(!v||v.width>c)v={r:g,largeArc:c>g?1:0,width:c,x:h.x,y:h.y};return v},null);if(m){var A=m.r;f.arcs.push(["A",A,A,
0,m.largeArc,1,m.x,m.y]);f.startPoint=h}return f},{startPoint:l,arcs:[]}).arcs;if(0!==f.length&&1!==f.length){f.unshift(["M",l.x,l.y]);var k={center:h,d:f}}}return k}})(m||(m={}));return m});n(a,"Series/DrawPointUtilities.js",[a["Core/Utilities.js"]],function(a){return{draw:function(a,b){var d=b.animatableAttribs,m=b.onComplete,u=b.css,l=b.renderer,q=a.series&&a.series.chart.hasRendered?void 0:a.series&&a.series.options.animation,h=a.graphic;b.attribs=b.attribs||{};b.attribs["class"]=a.getClassName();
if(a.shouldDraw())h||(a.graphic=h="text"===b.shapeType?l.text():l[b.shapeType](b.shapeArgs||{}),h.add(b.group)),u&&h.css(u),h.attr(b.attribs).animate(d,b.isNew?!1:q,m);else if(h){var k=function(){a.graphic=h=h&&h.destroy();"function"===typeof m&&m()};Object.keys(d).length?h.animate(d,void 0,function(){return k()}):k()}}}});n(a,"Series/Venn/VennPoint.js",[a["Core/Series/SeriesRegistry.js"],a["Core/Utilities.js"]],function(a,d){var b=this&&this.__extends||function(){var a=function(b,d){a=Object.setPrototypeOf||
{__proto__:[]}instanceof Array&&function(a,b){a.__proto__=b}||function(a,b){for(var d in b)Object.prototype.hasOwnProperty.call(b,d)&&(a[d]=b[d])};return a(b,d)};return function(b,d){function l(){this.constructor=b}if("function"!==typeof d&&null!==d)throw new TypeError("Class extends value "+String(d)+" is not a constructor or null");a(b,d);b.prototype=null===d?Object.create(d):(l.prototype=d.prototype,new l)}}(),x=d.isNumber;return function(a){function d(){var b=null!==a&&a.apply(this,arguments)||
this;b.options=void 0;b.series=void 0;return b}b(d,a);d.prototype.isValid=function(){return x(this.value)};d.prototype.shouldDraw=function(){return!!this.shapeArgs};return d}(a.seriesTypes.scatter.prototype.pointClass)});n(a,"Series/Venn/VennUtils.js",[a["Core/Geometry/CircleUtilities.js"],a["Core/Geometry/GeometryUtilities.js"],a["Core/Utilities.js"]],function(a,d,b){function n(a){var b=a.filter(function(a){return 2===a.sets.length}).reduce(function(a,c){c.sets.forEach(function(e,b,g){y(a[e])||(a[e]=
{overlapping:{},totalOverlap:0});a[e].totalOverlap+=c.value;a[e].overlapping[g[1-b]]=c.value});return a},{});a.filter(h).forEach(function(a){D(a,b[a.sets[0]])});return a}function m(a,b,g,c,e){var w=a(b),v=a(g);e=e||100;c=c||1e-10;var d=g-b,A=1;if(b>=g)throw Error("a must be smaller than b.");if(0<w*v)throw Error("f(a) and f(b) must have opposite signs.");if(0===w)var f=b;else if(0===v)f=g;else for(;A++<=e&&0!==h&&d>c;){d=(g-b)/2;f=b+d;var h=a(f);0<w*h?b=f:g=f}return f}function u(a){a=a.slice(0,-1);
for(var b=a.length,g=[],c=function(a,c){a.sum+=c[a.i];return a},e=0;e<b;e++)g[e]=a.reduce(c,{sum:0,i:e}).sum/b;return g}function l(a,b,g){var c=a+b;return 0>=g?c:J(a<b?a:b)<=g?0:m(function(c){c=p(a,b,c);return g-c},0,c)}function q(a){var b=0;2===a.length&&(b=a[0],a=a[1],b=p(b.r,a.r,C(b,a)));return b}function h(a){return r(a.sets)&&1===a.sets.length}function k(a){var b={};return y(a)&&E(a.value)&&-1<a.value&&r(a.sets)&&0<a.sets.length&&!a.sets.some(function(a){var c=!1;!b[a]&&I(a)?b[a]=!0:c=!0;return c})}
function x(a,b){return b.reduce(function(b,c){var e=0;1<c.sets.length&&(e=c.value,c=q(c.sets.map(function(c){return a[c]})),c=e-c,e=Math.round(c*c*1E11)/1E11);return b+e},0)}function L(a,b){return b.totalOverlap-a.totalOverlap}var J=a.getAreaOfCircle,K=a.getCircleCircleIntersection,p=a.getOverlapBetweenCircles,f=a.isPointInsideAllCircles,G=a.isPointInsideCircle,H=a.isPointOutsideAllCircles,C=d.getDistanceBetweenPoints,D=b.extend,r=b.isArray,E=b.isNumber,y=b.isObject,I=b.isString;return{geometry:d,
geometryCircles:a,addOverlapToSets:n,getCentroid:u,getDistanceBetweenCirclesByOverlap:l,getLabelWidth:function(a,b,g){var c=b.reduce(function(a,c){return Math.min(c.r,a)},Infinity),e=g.filter(function(c){return!G(a,c)});g=function(c,g){return m(function(d){var w={x:a.x+g*d,y:a.y};w=f(w,b)&&H(w,e);return-(c-d)+(w?0:Number.MAX_VALUE)},0,c)};return 2*Math.min(g(c,-1),g(c,1))},getMarginFromCircles:function(a,b,g){b=b.reduce(function(c,b){b=b.r-C(a,b);return b<=c?b:c},Number.MAX_VALUE);return b=g.reduce(function(c,
b){b=C(a,b)-b.r;return b<=c?b:c},b)},isSet:h,layoutGreedyVenn:function(a){var b=[],g={};a.filter(function(a){return 1===a.sets.length}).forEach(function(a){g[a.sets[0]]=a.circle={x:Number.MAX_VALUE,y:Number.MAX_VALUE,r:Math.sqrt(a.value/Math.PI)}});var c=function(a,c){var e=a.circle;e.x=c.x;e.y=c.y;b.push(a)};n(a);var e=a.filter(h).sort(L);c(e.shift(),{x:0,y:0});var d=a.filter(function(a){return 2===a.sets.length});e.forEach(function(a){var e=a.circle,f=e.r,w=a.overlapping,t=b.reduce(function(a,c,
F){var t=c.circle,h=l(f,t.r,w[c.sets[0]]),v=[{x:t.x+h,y:t.y},{x:t.x-h,y:t.y},{x:t.x,y:t.y+h},{x:t.x,y:t.y-h}];b.slice(F+1).forEach(function(a){var c=a.circle;a=l(f,c.r,w[a.sets[0]]);v=v.concat(K({x:t.x,y:t.y,r:h},{x:c.x,y:c.y,r:a}))});v.forEach(function(c){e.x=c.x;e.y=c.y;var b=x(g,d);b<a.loss&&(a.loss=b,a.coordinates=c)});return a},{loss:Number.MAX_VALUE,coordinates:void 0});c(a,t.coordinates)});return g},loss:x,nelderMead:function(a,b){var g=function(a,c){return a.fx-c.fx},c=function(a,c,b,e){return c.map(function(c,
d){return a*c+b*e[d]})},e=function(c,b){b.fx=a(b);c[c.length-1]=b;return c},d=function(b){var e=b[0];return b.map(function(b){b=c(.5,e,.5,b);b.fx=a(b);return b})},f=function(b,e,d,g){b=c(d,b,g,e);b.fx=a(b);return b};b=function(b){var c=b.length,e=Array(c+1);e[0]=b;e[0].fx=a(b);for(var d=0;d<c;++d){var g=b.slice();g[d]=g[d]?1.05*g[d]:.001;g.fx=a(g);e[d+1]=g}return e}(b);for(var F=0;100>F;F++){b.sort(g);var h=b[b.length-1],l=u(b),B=f(l,h,2,-1);if(B.fx<b[0].fx)h=f(l,h,3,-2),b=e(b,h.fx<B.fx?h:B);else if(B.fx>=
b[b.length-2].fx){var k=void 0;B.fx>h.fx?(k=f(l,h,.5,.5),b=k.fx<h.fx?e(b,k):d(b)):(k=f(l,h,1.5,-.5),b=k.fx<B.fx?e(b,k):d(b))}else b=e(b,B)}return b[0]},processVennData:function(a){a=r(a)?a:[];var b=a.reduce(function(a,b){k(b)&&h(b)&&0<b.value&&-1===a.indexOf(b.sets[0])&&a.push(b.sets[0]);return a},[]).sort(),d=a.reduce(function(a,e){k(e)&&!e.sets.some(function(a){return-1===b.indexOf(a)})&&(a[e.sets.sort().join()]=e);return a},{});b.reduce(function(a,b,d,g){g.slice(d+1).forEach(function(c){a.push(b+
","+c)});return a},[]).forEach(function(a){if(!d[a]){var b={sets:a.split(","),value:0};d[a]=b}});return Object.keys(d).map(function(a){return d[a]})},sortByTotalOverlap:L}});n(a,"Series/Venn/VennSeries.js",[a["Core/Animation/AnimationUtilities.js"],a["Core/Color/Color.js"],a["Core/Geometry/CircleUtilities.js"],a["Series/DrawPointUtilities.js"],a["Core/Geometry/GeometryUtilities.js"],a["Core/Series/SeriesRegistry.js"],a["Series/Venn/VennPoint.js"],a["Series/Venn/VennUtils.js"],a["Core/Legend/LegendSymbol.js"],
a["Core/Utilities.js"]],function(a,d,b,n,m,u,l,q,h,k){var x=this&&this.__extends||function(){var a=function(b,c){a=Object.setPrototypeOf||{__proto__:[]}instanceof Array&&function(a,b){a.__proto__=b}||function(a,b){for(var c in b)Object.prototype.hasOwnProperty.call(b,c)&&(a[c]=b[c])};return a(b,c)};return function(b,c){function e(){this.constructor=b}if("function"!==typeof c&&null!==c)throw new TypeError("Class extends value "+String(c)+" is not a constructor or null");a(b,c);b.prototype=null===c?
Object.create(c):(e.prototype=c.prototype,new e)}}(),z=a.animObject,J=d.parse,K=b.getAreaOfIntersectionBetweenCircles,p=b.getCirclesIntersectionPolygon,f=b.isCircle1CompletelyOverlappingCircle2,G=b.isPointInsideAllCircles,H=b.isPointOutsideAllCircles,C=m.getCenterOfPoints,D=u.seriesTypes.scatter;a=k.addEvent;var r=k.extend,E=k.isArray,y=k.isNumber,I=k.isObject,A=k.merge;k=function(a){function b(){var b=null!==a&&a.apply(this,arguments)||this;b.data=void 0;b.mapOfIdToRelation=void 0;b.options=void 0;
b.points=void 0;return b}x(b,a);b.getLabelPosition=function(a,b){var c=a.reduce(function(c,d){var e=d.r/2;return[{x:d.x,y:d.y},{x:d.x+e,y:d.y},{x:d.x-e,y:d.y},{x:d.x,y:d.y+e},{x:d.x,y:d.y-e}].reduce(function(c,d){var e=q.getMarginFromCircles(d,a,b);c.margin<e&&(c.point=d,c.margin=e);return c},c)},{point:void 0,margin:-Number.MAX_VALUE}).point;c=q.nelderMead(function(c){return-q.getMarginFromCircles({x:c[0],y:c[1]},a,b)},[c.x,c.y]);c={x:c[0],y:c[1]};G(c,a)&&H(c,b)||(c=1<a.length?C(p(a)):{x:a[0].x,
y:a[0].y});return c};b.getLabelValues=function(a,d){var c=a.sets,e=d.reduce(function(a,b){var d=-1<c.indexOf(b.sets[0]);a[d?"internal":"external"].push(b.circle);return a},{internal:[],external:[]});e.external=e.external.filter(function(a){return e.internal.some(function(b){return!f(a,b)})});a=b.getLabelPosition(e.internal,e.external);d=q.getLabelWidth(a,e.internal,e.external);return{position:a,width:d}};b.layout=function(a){var c={},d={};if(0<a.length){var f=q.layoutGreedyVenn(a),g=a.filter(q.isSet);
a.forEach(function(a){var e=a.sets,h=e.join();if(e=q.isSet(a)?f[h]:K(e.map(function(a){return f[a]})))c[h]=e,d[h]=b.getLabelValues(a,g)})}return{mapOfIdToShape:c,mapOfIdToLabelValues:d}};b.getScale=function(a,b,d){var c=d.bottom-d.top,e=d.right-d.left;c=Math.min(0<e?1/e*a:1,0<c?1/c*b:1);return{scale:c,centerX:a/2-(d.right+d.left)/2*c,centerY:b/2-(d.top+d.bottom)/2*c}};b.updateFieldBoundaries=function(a,b){var c=b.x-b.r,d=b.x+b.r,e=b.y+b.r;b=b.y-b.r;if(!y(a.left)||a.left>c)a.left=c;if(!y(a.right)||
a.right<d)a.right=d;if(!y(a.top)||a.top>b)a.top=b;if(!y(a.bottom)||a.bottom<e)a.bottom=e;return a};b.prototype.animate=function(a){if(!a){var b=z(this.options.animation);this.points.forEach(function(a){var c=a.shapeArgs;if(a.graphic&&c){var d={},e={};c.d?d.opacity=.001:(d.r=0,e.r=c.r);a.graphic.attr(d).animate(e,b);c.d&&setTimeout(function(){a&&a.graphic&&a.graphic.animate({opacity:1})},b.duration)}},this)}};b.prototype.drawPoints=function(){var a=this,b=a.chart,d=a.group,f=b.renderer;(a.points||
[]).forEach(function(c){var e={zIndex:E(c.sets)?c.sets.length:0},h=c.shapeArgs;b.styledMode||r(e,a.pointAttribs(c,c.state));n.draw(c,{isNew:!c.graphic,animatableAttribs:h,attribs:e,group:d,renderer:f,shapeType:h&&h.d?"path":"circle"})})};b.prototype.init=function(){D.prototype.init.apply(this,arguments);delete this.opacity};b.prototype.pointAttribs=function(a,b){var c=this.options||{};a=A(c,{color:a&&a.color},a&&a.options||{},b&&c.states[b]||{});return{fill:J(a.color).brighten(a.brightness).get(),
opacity:a.opacity,stroke:a.borderColor,"stroke-width":a.borderWidth,dashstyle:a.borderDashStyle}};b.prototype.translate=function(){var a=this.chart;this.processedXData=this.xData;this.generatePoints();var d=q.processVennData(this.options.data);d=b.layout(d);var f=d.mapOfIdToShape,h=d.mapOfIdToLabelValues;d=Object.keys(f).filter(function(a){return(a=f[a])&&y(a.r)}).reduce(function(a,c){return b.updateFieldBoundaries(a,f[c])},{top:0,bottom:0,left:0,right:0});a=b.getScale(a.plotWidth,a.plotHeight,d);
var g=a.scale,k=a.centerX,l=a.centerY;this.points.forEach(function(a){var b=E(a.sets)?a.sets:[],c=b.join(),d=f[c],e=h[c]||{};c=e.width;e=e.position;var m=a.options&&a.options.dataLabels;if(d){if(d.r)var n={x:k+d.x*g,y:l+d.y*g,r:d.r*g};else d.d&&(d=d.d,d.forEach(function(a){"M"===a[0]?(a[1]=k+a[1]*g,a[2]=l+a[2]*g):"A"===a[0]&&(a[1]*=g,a[2]*=g,a[6]=k+a[6]*g,a[7]=l+a[7]*g)}),n={d:d});e?(e.x=k+e.x*g,e.y=l+e.y*g):e={};y(c)&&(c=Math.round(c*g))}a.shapeArgs=n;e&&n&&(a.plotX=e.x,a.plotY=e.y);c&&n&&(a.dlOptions=
A(!0,{style:{width:c}},I(m,!0)?m:void 0));a.name=a.options.name||b.join("\u2229")})};b.defaultOptions=A(D.defaultOptions,{borderColor:"#cccccc",borderDashStyle:"solid",borderWidth:1,brighten:0,clip:!1,colorByPoint:!0,dataLabels:{enabled:!0,verticalAlign:"middle",formatter:function(){return this.point.name}},inactiveOtherPoints:!0,marker:!1,opacity:.75,showInLegend:!1,legendType:"point",states:{hover:{opacity:1,borderColor:"#333333"},select:{color:"#cccccc",borderColor:"#000000",animation:!1},inactive:{opacity:.075}},
tooltip:{pointFormat:"{point.name}: {point.value}"}});return b}(D);r(k.prototype,{axisTypes:[],directTouch:!0,drawLegendSymbol:h.drawRectangle,isCartesian:!1,pointArrayMap:["value"],pointClass:l,utils:q});u.registerSeriesType("venn",k);"";a(k,"afterSetOptions",function(a){var b=a.options.states;this.is("venn")&&Object.keys(b).forEach(function(a){b[a].halo=!1})});return k});n(a,"masters/modules/venn.src.js",[],function(){})});
//# sourceMappingURL=venn.js.map