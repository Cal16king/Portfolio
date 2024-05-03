xquery version "3.1";

declare variable $data := doc('results.xml');
declare variable $colors := ('blue', 'green', 'red', 'orange');
declare variable $wordsOfInterest := ('market', 'year', 'inflation', 'growth');
declare variable $wordCounts := 
    for $word in $wordsOfInterest
    return count($data//key[contains(@name, $word)]);

declare variable $maxCount := max($wordCounts);


let $barWidth := 50
let $barSpacing := 10
let $bottomMargin := 40 
let $svgWidth := (count($wordsOfInterest) * ($barWidth + $barSpacing)) + $barSpacing + 100 
let $svgHeight := 300 + $bottomMargin + 100  

return
    <svg xmlns="http://www.w3.org/2000/svg" width="{$svgWidth}" height="{$svgHeight}">
        <g transform="translate(50,20)"> 
            {
                for $i in 1 to count($wordsOfInterest)
                let $word := $wordsOfInterest[$i]
                let $color := $colors[$i]
                let $count := $wordCounts[$i]
                let $barHeight := $count * ($svgHeight - $barSpacing - $bottomMargin) div $maxCount
                let $x := ($i - 1) * ($barWidth + $barSpacing) + $barSpacing
                let $y := $svgHeight - $barHeight - $bottomMargin
                let $textX := $x + $barWidth div 2
                let $textY := $svgHeight - $bottomMargin + 15 

                return
                    <g>
                        <rect x="{$x}" y="{$y}" width="{$barWidth}" height="{$barHeight}" fill="{$color}"/>
                        <text x="{$textX}" y="{$textY}" text-anchor="middle" fill="black">{$word}</text>
                        <text x="{$textX}" y="{$y - 5}" text-anchor="middle" fill="black">{$count}</text>
                    </g>
            }
        </g>
    </svg>
