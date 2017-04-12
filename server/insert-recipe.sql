WITH x AS (
    INSERT INTO recipes (title, notes, favorite)
    VALUES (($1), ($2), ($3))
    RETURNING recipeId
),
b AS (
    INSERT INTO ingredients (recipeid, ingredient, ordernumber)
    VALUES ((select recipeid from x), ANY($4::text), 5)
)
INSERT INTO instructions (recipeid, instruction, ordernumber)
VALUES ((select recipeid from x), 'something else', 8); 