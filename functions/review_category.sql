CREATE OR REPLACE FUNCTION review_category(review_score NUMBER)
RETURNS STRING
LANGUAGE SQL
AS
$$
    CASE
        WHEN review_score = 5 THEN 'Excellent'
        WHEN review_score = 4 THEN 'Good'
        WHEN review_score = 3 THEN 'Average'
        WHEN review_score = 2 THEN 'Poor'
        WHEN review_score = 1 THEN 'Very Poor'
        ELSE 'Unknown'
    END
$$;