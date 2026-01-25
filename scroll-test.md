---
layout: default
title: Scroll Test - Tillerstead
permalink: /scroll-test/
---

<div style="padding: 2rem;">
  
  <h1>Scroll Test Page</h1>
  <p>This page tests that scrolling works properly.</p>
  
  <div id="scroll-status" style="position: fixed; top: 100px; right: 20px; background: #00a35c; color: white; padding: 1rem; border-radius: 8px; z-index: 10000; max-width: 300px;">
    <h3 style="margin: 0 0 0.5rem 0; color: white;">Scroll Monitor</h3>
    <p style="margin: 0.25rem 0; color: white;"><strong>Scroll Y:</strong> <span id="scroll-y">0</span>px</p>
    <p style="margin: 0.25rem 0; color: white;"><strong>Page Height:</strong> <span id="page-height">0</span>px</p>
    <p style="margin: 0.25rem 0; color: white;"><strong>Body Overflow:</strong> <span id="body-overflow">auto</span></p>
    <p style="margin: 0.25rem 0; color: white;"><strong>HTML Overflow:</strong> <span id="html-overflow">scroll</span></p>
    <p style="margin: 0.25rem 0; color: white;"><strong>Can Scroll:</strong> <span id="can-scroll">YES</span></p>
  </div>
  
  <div style="margin-top: 2rem;">
    <h2>Test Sections (Scroll Down)</h2>
    <p>Keep scrolling to test that the page scrolls smoothly...</p>
  </div>
  
  <!-- Section 1 -->
  <div style="height: 100vh; background: linear-gradient(135deg, #00a35c, #006b3d); display: flex; align-items: center; justify-content: center; color: white; font-size: 3rem; font-weight: 900; margin: 2rem 0; border-radius: 12px;">
    Section 1 - Keep Scrolling
  </div>
  
  <!-- Section 2 -->
  <div style="height: 100vh; background: linear-gradient(135deg, #d4af37, #9c7a14); display: flex; align-items: center; justify-content: center; color: white; font-size: 3rem; font-weight: 900; margin: 2rem 0; border-radius: 12px;">
    Section 2 - Scroll Working
  </div>
  
  <!-- Section 3 -->
  <div style="height: 100vh; background: linear-gradient(135deg, #00a35c, #d4af37); display: flex; align-items: center; justify-content: center; color: white; font-size: 3rem; font-weight: 900; margin: 2rem 0; border-radius: 12px;">
    Section 3 - Keep Going
  </div>
  
  <!-- Section 4 -->
  <div style="height: 100vh; background: linear-gradient(135deg, #006b3d, #00a35c); display: flex; align-items: center; justify-content: center; color: white; font-size: 3rem; font-weight: 900; margin: 2rem 0; border-radius: 12px;">
    Section 4 - Almost There
  </div>
  
  <!-- Section 5 -->
  <div style="height: 100vh; background: linear-gradient(135deg, #9c7a14, #d4af37); display: flex; align-items: center; justify-content: center; color: white; font-size: 3rem; font-weight: 900; margin: 2rem 0; border-radius: 12px;">
    Section 5 - SCROLL WORKS! 🎉
  </div>
  
  <div style="padding: 3rem 0; text-align: center; background: #f8f7f5; border-radius: 12px;">
    <h2>You Made It!</h2>
    <p>If you can see this, scrolling is working perfectly!</p>
    <a href="#" onclick="window.scrollTo({top: 0, behavior: 'smooth'}); return false;" class="btn btn--primary" style="margin-top: 1rem;">
      Scroll to Top
    </a>
  </div>
  
</div>

<script>
(function() {
  'use strict';
  
  function updateScrollInfo() {
    const scrollY = Math.round(window.pageYOffset);
    const pageHeight = document.documentElement.scrollHeight;
    const bodyOverflow = getComputedStyle(document.body).overflowY;
    const htmlOverflow = getComputedStyle(document.documentElement).overflowY;
    const canScroll = pageHeight > window.innerHeight;
    
    document.getElementById('scroll-y').textContent = scrollY;
    document.getElementById('page-height').textContent = pageHeight;
    document.getElementById('body-overflow').textContent = bodyOverflow;
    document.getElementById('html-overflow').textContent = htmlOverflow;
    document.getElementById('can-scroll').textContent = canScroll ? 'YES ✅' : 'NO ❌';
    
    // Log issues
    if (bodyOverflow === 'hidden' || htmlOverflow === 'hidden') {
      console.error('SCROLL BLOCKED! overflow:hidden detected');
    }
    
    if (!canScroll) {
      console.warn('Page not tall enough to scroll');
    }
  }
  
  // Update on scroll
  window.addEventListener('scroll', updateScrollInfo, { passive: true });
  
  // Update on resize
  window.addEventListener('resize', updateScrollInfo, { passive: true });
  
  // Initial update
  updateScrollInfo();
  
  // Update every second to catch changes
  setInterval(updateScrollInfo, 1000);
  
  // Test scroll programmatically
  console.log('[SCROLL TEST] Running diagnostic...');
  console.log('Body overflow-y:', getComputedStyle(document.body).overflowY);
  console.log('HTML overflow-y:', getComputedStyle(document.documentElement).overflowY);
  console.log('Body height:', document.body.scrollHeight);
  console.log('Window height:', window.innerHeight);
  console.log('Can scroll:', document.body.scrollHeight > window.innerHeight);
  
})();
</script>

<style>
/* Ensure test page can scroll */
#scroll-status {
  pointer-events: none !important;
}
#scroll-status * {
  pointer-events: auto !important;
}
</style>
```
