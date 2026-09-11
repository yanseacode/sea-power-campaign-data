# Narrative and Localization

## Three layers

Sea Power campaign narrative is assembled from three related systems:

1. **Campaign timeline presentation** — localized node title, date, location, description, tile, mission sequence label, special notes, resupply rules, warnings, and reward notices in `campaign.ini`.
2. **Briefing documents** — external XAML/XML panels and generated briefing-map text referenced by language-specific path fields.
3. **In-mission and debrief text** — localized mission/objective strings, trigger messages, result text, completion notices, and post-node events.

`FreeEvent` and `NewspaperEvent` nodes use the same numbered campaign timeline as missions. Their localized asset paths point to articles, orders, situation reports, slideshows, or endings. They can have parents, conditions, expiry, and completion actions like other nodes.

## Asset conventions

Campaign-local art normally lives below `campaigns/<id>/art/`, often with language subdirectories. Mission briefings may live beside the mission in a generated briefing folder. Build #364 fixed editor creation of briefing folders and unified previews between legacy and generated-map formats. It also added rich-text editing that creates `BriefingText_xy.xml` assets.

Use relative paths from the content root expected by the relevant field. Exact casing and separators should match shipped examples even on Windows, because mods may later be moved or packaged.

## Localization

Common patterns include `[Language_en]` sections and suffixes such as `_en`, `_ru`, or `_cn`. Do not assume fallback across every UI surface. Declare only languages actually supplied, and run a non-English smoke test before claiming fallback support.

Dynamic values can be inserted through supported binding tokens in presentation files and commander settings. Reuse tokens proven in the same view; a token accepted by one XAML view is not automatically accepted by another.

## Narrative contract

For every tactical node, define:

- what the player knows before launch;
- objectives and restrictions;
- logistics and force-selection state;
- success, costly-success, and failure messaging;
- mechanical rewards and persistent consequences;
- what the next node says about the outcome.

Presentation text does not enforce mechanics. Every claimed restriction or reward must correspond to actual campaign, mission, trigger, or persistence fields.
