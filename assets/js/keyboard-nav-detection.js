/**
 * Keyboard Navigation Detection
 * 
 * Detects when user is navigating with keyboard (Tab key)
 * and adds 'keyboard-nav' class to body for enhanced focus indicators.
 * 
 * This allows us to show focus outlines only for keyboard users,
 * not for mouse clicks, improving both UX and accessibility.
 */

(function() {
  'use strict';
  
  // Track if user is using keyboard
  let isUsingKeyboard = false;
  
  // Detect Tab key press
  document.addEventListener('keydown', function(e) {
    if (e.key === 'Tab') {
      isUsingKeyboard = true;
      document.body.classList.add('keyboard-nav');
    }
  });
  
  // Detect mouse click - remove keyboard indicator
  document.addEventListener('mousedown', function() {
    if (isUsingKeyboard) {
      isUsingKeyboard = false;
      document.body.classList.remove('keyboard-nav');
    }
  });
  
  // Detect touch - remove keyboard indicator
  document.addEventListener('touchstart', function() {
    if (isUsingKeyboard) {
      isUsingKeyboard = false;
      document.body.classList.remove('keyboard-nav');
    }
  });
  
})();
