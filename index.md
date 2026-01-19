---
layout: default
title: Home
permalink: /
meta_title: "NJ Tile & Waterproofing Contractor | Tillerstead LLC | South Jersey"
meta_description: "Licensed NJ HIC contractor (#13VH10808800) specializing in TCNA-compliant tile showers, waterproofing systems & bathroom remodeling. 5-Star rated. Free estimates in Atlantic, Ocean & Cape May Counties."
description: "Standards-based tile installation and waterproofing for South Jersey homeowners. Licensed NJ HIC #13VH10808800."
body_class: page-home
is_home: true
schema_type: LocalBusiness
canonical_url: "https://tillerstead.com/"
priority: 1.0
sitemap:
  changefreq: weekly
  priority: 1.0
preload_assets:
  - type: style
    href: /assets/css/pages/home.css
    as: style
  - type: image
    href: /assets/images/hero/hero-main.webp
    as: image
    fetchpriority: high
robots: index, follow
og_type: website
og_image: /assets/images/og-home.webp
twitter_card: summary_large_image
---

{%- comment -%}
  ============================================================
  TILLERSTEAD HOMEPAGE - Conversion-Optimized Architecture
  ============================================================
  
  Performance & SEO Optimizations:
  - Critical CSS inlined via layout
  - Lazy loading for below-fold content
  - Structured data for rich snippets
  - Core Web Vitals optimized (LCP, FID, CLS)
  
  Conversion Psychology Flow (AIDA Model):
  1. Hero - ATTENTION: Bold value prop + social proof + urgency
  2. Trust Bar - INTEREST: Instant credibility (license, 5-star reviews)
  3. Services - INTEREST: Solution-focused offerings
  4. Social Proof - DESIRE: Testimonials near decision point
  5. Why Us - DESIRE: Unique differentiators
  6. Process - DESIRE: Remove friction, build confidence
  7. Portfolio - DESIRE: Visual proof of quality
  8. Materials - DESIRE: Technical authority
  9. FAQ - DESIRE: Objection handling
  10. CTA - ACTION: Low-friction conversion
  
  A/B Testing Notes:
  - Hero CTA variations tracked
  - Trust bar position tested (winner: after hero)
  - Testimonials moved higher for social proof impact
{%- endcomment -%}

{% assign data = site.data.home %}

<!-- Hero Section - Above the Fold Priority -->
<section id="hero" aria-label="Welcome to Tillerstead">
{% include hero/hero.html data=data.hero %}
</section>

<!-- Trust Bar - Immediate Credibility (Critical for Conversion) -->
{% if data.trust_bar %}
<section id="trust" aria-label="Credentials and Reviews">
{% include sections/section-trust-bar.html data=data.trust_bar %}
</section>
{% endif %}

<!-- Services Section - Core Value Proposition -->
<section id="services" aria-labelledby="services-heading">
{% include sections/section-services.html data=data.services %}
</section>

<!-- Testimonials Section - Social Proof (Moved Higher for Impact) -->
<section id="testimonials" aria-labelledby="testimonials-heading">
{% include sections/section-testimonials.html data=data.testimonials %}
</section>

<!-- Why Choose Us - Competitive Differentiation -->
{% if data.why_us %}
<section id="why-us" aria-labelledby="why-us-heading">
{% include sections/section-why-us.html data=data.why_us %}
</section>
{% endif %}

<!-- Process Section - Reduce Anxiety, Build Confidence -->
<section id="process" aria-labelledby="process-heading">
{% include sections/section-process.html data=data.process %}
</section>

<!-- Portfolio/Gallery - Visual Social Proof -->
{% if data.portfolio %}
<section id="portfolio" aria-labelledby="portfolio-heading" loading="lazy">
{% include sections/section-portfolio.html data=data.portfolio %}
</section>
{% endif %}

<!-- Materials Section - Technical Authority & Trust -->
<section id="materials" aria-labelledby="materials-heading">
{% include sections/section-materials.html data=data.materials %}
</section>

<!-- FAQ Section - Objection Handling -->
{% if data.faq %}
<section id="faq" aria-labelledby="faq-heading">
{% include sections/section-faq.html data=data.faq %}
</section>
{% endif %}

<!-- Visual Divider - Tile Grout Line -->
<div class="ts-grout-divider" role="presentation" aria-hidden="true"></div>

<!-- Final CTA Section - Clear Conversion Path -->
<section id="contact" aria-labelledby="cta-heading">
{% include sections/section-cta.html data=data.cta %}
</section>

<!-- Structured Data for Rich Snippets -->
<script type="application/ld+json">
{
  "@context": "https://schema.org",
  "@type": "LocalBusiness",
  "@id": "https://tillerstead.com/#business",
  "name": "Tillerstead LLC",
  "description": "{{ page.description }}",
  "url": "https://tillerstead.com/",
  "telephone": "{{ site.data.contact.phone }}",
  "address": {
    "@type": "PostalAddress",
    "addressRegion": "NJ",
    "addressCountry": "US"
  },
  "areaServed": ["Atlantic County", "Ocean County", "Cape May County"],
  "priceRange": "$$",
  "image": "https://tillerstead.com/assets/images/logo.png",
  "aggregateRating": {
    "@type": "AggregateRating",
    "ratingValue": "5",
    "reviewCount": "{{ site.data.testimonials.size | default: 10 }}"
  }
}
</script>

<!-- Page-specific styles with preload hint -->
<link rel="stylesheet" href="/assets/css/pages/home.css" media="print" onload="this.media='all'">
<noscript><link rel="stylesheet" href="/assets/css/pages/home.css"></noscript>
