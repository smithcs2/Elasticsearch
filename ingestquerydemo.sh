echo Put some test data into AWS venice-es Elasticsearch cluster for demo
read -p "Press return to continue... "
curl -XPUT 'http://search-venice-es-pjebjkdaueu2gukocyccj4r5m4.us-east-1.es.amazonaws.com/twitter/user/kimchy' -d '{ "name" : "Shay Banon" }'
curl -XPUT 'http://search-venice-es-pjebjkdaueu2gukocyccj4r5m4.us-east-1.es.amazonaws.com/twitter/tweet/1' -d '
{
    "user": "kimchy",
    "postDate": "2009-11-15T13:12:00",
    "message": "Trying out Elasticsearch, so far so good?"
}'
curl -XPUT 'http://search-venice-es-pjebjkdaueu2gukocyccj4r5m4.us-east-1.es.amazonaws.com/twitter/tweet/2' -d '
{
    "user": "kimchy",
    "postDate": "2009-11-15T14:12:12",
    "message": "Another tweet, will it be indexed?"
}'
echo query to see if our "Twitter" data is in the index
read -p "Press return to continue... "
curl -XGET 'http://search-venice-es-pjebjkdaueu2gukocyccj4r5m4.us-east-1.es.amazonaws.com/twitter/user/kimchy' --data-urlencode "?pretty=true"
curl -XGET 'http://search-venice-es-pjebjkdaueu2gukocyccj4r5m4.us-east-1.es.amazonaws.com/twitter/tweet/1' --data-urlencode "?pretty=true"
curl -XGET 'http://search-venice-es-pjebjkdaueu2gukocyccj4r5m4.us-east-1.es.amazonaws.com/twitter/tweet/2' --data-urlencode "?pretty=true"
echo try some queries: specific, matchall, date range
read -p "Press return to continue... "
curl -XGET 'http://search-venice-es-pjebjkdaueu2gukocyccj4r5m4.us-east-1.es.amazonaws.com/twitter/tweet/_search?pretty=true' -d '
{
    "query" : {
        "match" : { "user": "kimchy" }
    }
}'
curl -XGET 'http://search-venice-es-pjebjkdaueu2gukocyccj4r5m4.us-east-1.es.amazonaws.com/twitter/_search?pretty=true' -d '
{
    "query" : {
        "matchAll" : {}
    }
}'
curl -XGET 'http://search-venice-es-pjebjkdaueu2gukocyccj4r5m4.us-east-1.es.amazonaws.com/twitter/_search?pretty=true' -d '
{
    "query" : {
        "range" : {
            "postDate" : { "from" : "2009-11-15T13:00:00", "to" : "2009-11-15T14:00:00" }
        }
    }
}'
echo Another way to define our simple twitter system is to have a different index per user...
read -p "Press return to continue... "
curl -XPUT 'http://search-venice-es-pjebjkdaueu2gukocyccj4r5m4.us-east-1.es.amazonaws.com/kimchy/info/1' -d '{ "name" : "Shay Banon" }'

curl -XPUT 'http://search-venice-es-pjebjkdaueu2gukocyccj4r5m4.us-east-1.es.amazonaws.com/kimchy/tweet/1' -d '
{
    "user": "kimchy",
    "postDate": "2009-11-15T13:12:00",
    "message": "Trying out Elasticsearch, so far so good?"
}'

curl -XPUT 'http://search-venice-es-pjebjkdaueu2gukocyccj4r5m4.us-east-1.es.amazonaws.com/kimchy/tweet/2' -d '
{
    "user": "kimchy",
    "postDate": "2009-11-15T14:12:12",
    "message": "Another tweet, will it be indexed?"
}'
echo The above will index information into the @kimchy@ index, with two types, @info@ and @tweet@. Each user will get his own special index.
echo We can search on more than one index or on all indices... 
read -p "Press return to continue... "
curl -XGET 'http://search-venice-es-pjebjkdaueu2gukocyccj4r5m4.us-east-1.es.amazonaws.com/kimchy,another_user/_search?pretty=true' -d '
{
    "query" : {
        "matchAll" : {}
    }
}'
curl -XGET 'http://search-venice-es-pjebjkdaueu2gukocyccj4r5m4.us-east-1.es.amazonaws.com/_search?pretty=true' -d '
{
    "query" : {
        "matchAll" : {}
    }
}'
