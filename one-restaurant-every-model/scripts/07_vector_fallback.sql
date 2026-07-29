-- Lab 8 FALLBACK: used only if MENU_MODEL cannot be loaded at all (e.g. the
-- object-storage download is blocked by egress rules on a locked-down tenancy).
--
-- History worth recording: this file used to hold PLACEHOLDERS for precomputed
-- vector literals ('[...384 floats...]') that were never generated, so it was
-- not runnable. Shipping ten 384-float literals inside the guide would also be
-- ~10 KB of unreadable text. This is the honest substitute instead: it needs no
-- model, it runs, and it teaches the contrast directly.
--
-- What you lose: semantic search. What you keep: the ability to finish the lab
-- and to SEE what the embedding was buying you.

-- 1. Keyword search - what you get WITHOUT vectors.
--    The probe 'spicy vegetarian noodles' shares no keyword with the dish that
--    actually satisfies it, so this returns nothing.
SELECT item_name, price
FROM   item
WHERE  active
AND    (LOWER(item_name || ' ' || description) LIKE '%spicy%'
   AND  LOWER(item_name || ' ' || description) LIKE '%vegetarian%'
   AND  LOWER(item_name || ' ' || description) LIKE '%noodle%');

-- 2. Loosen it to ANY of the words. This returns exactly ONE row - Beef Chow
--    Fun - the one dish that is emphatically NOT vegetarian. It matched on
--    "noodles"; keyword search cannot know that "wok-seared beef" disqualifies
--    it. The dish you wanted (Szechuan Tofu Stir-Fry) never appears: its
--    description says "fiery" not "spicy", and "no meat" not "vegetarian".
SELECT item_name, price
FROM   item
WHERE  active
AND    (LOWER(item_name || ' ' || description) LIKE '%spicy%'
    OR  LOWER(item_name || ' ' || description) LIKE '%vegetarian%'
    OR  LOWER(item_name || ' ' || description) LIKE '%noodle%')
ORDER  BY item_name;

-- That gap - nothing, or noise, with no way to rank by closeness - is the
-- whole reason AI Vector Search exists. Ask a proctor to help get MENU_MODEL
-- loaded (Lab 7, Task 1) so you can run the real thing.
