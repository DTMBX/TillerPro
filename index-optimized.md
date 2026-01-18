---
layout: default
title: Home
permalink: /index-optimized
meta_title: "NJ Tile & Waterproofing Contractor | Tillerstead LLC"
meta_description: "Licensed NJ HIC contractor specializing in TCNA-compliant tile showers, waterproofing systems, and bathroom remodeling. Serving Atlantic, Ocean & Cape May Counties."
description: "Standards-based tile installation and waterproofing for South Jersey homeowners. Licensed NJ HIC #13VH10808800."
body_class: page-home
is_home: true
---

{%- comment -%}
  ============================================================
  OPTIMIZED HOMEPAGE - Uses Organized Includes
  ============================================================
  
  This is the NEW optimized homepage that leverages our 
  organized _includes directory structure.
  
  Benefits:
  - Clean, maintainable code (was 848 lines, now <100)
  - Reusable components across all pages
  - Centralized content management via _data/home.yml
  - Easy to update and test individual sections
  - Follows Tillerstead taxonomy standards
  
  Structure:
  1. Hero Section (hero/)
  2. Services Preview (sections/)
  3. Process Overview (sections/)
  4. Materials/Compliance (sections/)
  5. Social Proof/Testimonials (sections/)
  6. Final CTA (sections/)
  
  All content is managed in _data/home.yml for easy updates.
{%- endcomment -%}

{%- assign data = site.data.home -%}

<!-- 1. Hero Section -->
{% include hero/hero.html 
   eyebrow=data.hero.eyebrow
   title=data.hero.title
   subtitle=data.hero.subtitle
   summary=data.hero.summary
   primary_label=data.hero.primary.label
   primary_url=data.hero.primary.url
   secondary_label=data.hero.secondary.label
   secondary_url=data.hero.secondary.url
   image="/assets/img/tillerstead-work/bathrooms/after-entry-shot.jpg"
   image_alt="TCNA-compliant bathroom tile installation by Tillerstead LLC"
   facts=data.hero.facts
   highlights=data.hero.highlights
%}

<!-- 2. Services Preview Section -->
{% include sections/home-services-preview.html
   eyebrow=data.services.eyebrow
   title=data.services.title
   summary=data.services.summary
   cards=data.services.cards
   primary_label=data.services.actions.primary.label
   primary_url=data.services.actions.primary.url
   secondary_label=data.services.actions.secondary.label
   secondary_url=data.services.actions.secondary.url
%}

<!-- 3. Process Section -->
{% include sections/ts-process.html
   eyebrow=data.process.eyebrow
   title=data.process.title
   summary=data.process.summary
   steps=data.process.steps
   fun_fact=data.process.fun_fact
%}

<!-- 4. Materials & Standards Section -->
{% include sections/home-materials.html
   eyebrow=data.materials.eyebrow
   title=data.materials.title
   summary=data.materials.summary
   callout=data.materials.callout
   items=data.materials.items
   note=data.materials.note
%}

<!-- 5. Testimonials Section -->
{% include sections/testimonials.html
   eyebrow=data.testimonials.eyebrow
   title=data.testimonials.title
   limit=data.testimonials.limit
   reviews=site.data.reviews.reviews
%}

<!-- 6. Final CTA Section -->
{% include sections/home-cta-final.html
   eyebrow=data.cta.eyebrow
   title=data.cta.title
   summary=data.cta.summary
   primary_label=data.cta.primary.label
   primary_url=data.cta.primary.url
   secondary_label=data.cta.secondary.label
   secondary_url=data.cta.secondary.url
   note=data.cta.note
%}

<link rel="stylesheet" href="/assets/css/pages/home.css">
