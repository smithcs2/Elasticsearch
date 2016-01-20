read -p "Ready to delete twitter and kimchy indices. Press return to continue... "
curl -XDELETE 'http://search-venice-es-pjebjkdaueu2gukocyccj4r5m4.us-east-1.es.amazonaws.com/twitter/';
curl -XDELETE 'http://search-venice-es-pjebjkdaueu2gukocyccj4r5m4.us-east-1.es.amazonaws.com/kimchy/'