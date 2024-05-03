declare variable $wordsOfInterest := ('inflation', 'market', 'rate', 'march', 'prices', 'tesla');
declare variable $data := doc('results.xml');

let $dates := distinct-values($data//key/date)

let $counts :=
    for $date in $dates
    order by xs:date($date) descending
    return
        for $word in $wordsOfInterest
        let $occurrences := $data//key[contains(@name, $word) and date = $date]
        return ($date || ':' || count($occurrences) || ':' || $word || '&#10;')

return $counts
