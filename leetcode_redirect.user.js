// ==UserScript==
// @name         LeetCode Redirect
// @namespace    http://tampermonkey.net/
// @version      0.1
// @description  Add a button to redirect from leetcode.cn to leetcode.com
// @author       dustynight but actullay cursor lol
// @match        *://*.leetcode.cn/*
// @grant        none
// ==/UserScript==

(function() {
    'use strict';
    
    // Create the redirect button
    const redirectButton = document.createElement('button');
    redirectButton.textContent = 'Go to LeetCode.com';
    redirectButton.style.position = 'fixed';
    redirectButton.style.top = '10px';
    redirectButton.style.right = '10px';
    redirectButton.style.zIndex = '9999';
    redirectButton.style.padding = '8px 12px';
    redirectButton.style.backgroundColor = '#3498db';
    redirectButton.style.color = 'white';
    redirectButton.style.border = 'none';
    redirectButton.style.borderRadius = '4px';
    redirectButton.style.cursor = 'pointer';
    redirectButton.style.fontWeight = 'bold';
    
    // Add hover effect
    redirectButton.addEventListener('mouseover', function() {
        this.style.backgroundColor = '#2980b9';
    });
    
    redirectButton.addEventListener('mouseout', function() {
        this.style.backgroundColor = '#3498db';
    });
    
    // Add click handler to redirect
    redirectButton.addEventListener('click', function() {
        const currentUrl = window.location.href;
        const newUrl = currentUrl.replace('leetcode.cn', 'leetcode.com');
        window.location.href = newUrl;
    });
    
    // Add button to page
    document.body.appendChild(redirectButton);
})(); 