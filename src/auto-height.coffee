###*
# @version 0.0.5
# @copyright Emanuel Imhof [All Rights Reserved]
# @license MIT License (see LICENSE.txt)
###
angular.module('m43nu.auto-height', []).
  directive 'autoHeight', [ '$window', '$timeout', ($window, $timeout) ->
    link: ($scope, $element, $attrs) ->
      combineHeights = (collection) ->
        heights = 0
        heights += node.offsetHeight for node in collection
        heights

      siblings = ($elm) ->
        elm for elm in $elm.parent().children() when elm != $elm[0]

      angular.element($window).bind 'resize', ->
        additionalHeight = $attrs.additionalHeight || 0
        parent = $element.parent()[0]
        if parent and parent.getBoundingClientRect
          parentHeight = $window.innerHeight - parent.getBoundingClientRect().top
          $element.css('height', (parentHeight - combineHeights(siblings($element)) - additionalHeight) + "px")

      $timeout ->
        angular.element($window).triggerHandler('resize')
      , 1000
  ]