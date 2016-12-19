API_URL = "https://spreadsheets.google.com/feeds/list/1j6qQrXMt1DNh8QAyov7Q2dSkkcJeqpXr5_1kCz1LWFw/default/public/values?alt=json"

# nom: _cn6ca
# commentaires: _cztg3

days =
  lundi: 'pzh4'
  mardi: 're1l'
  mercredi: 'hk2m'
  jeudi: 'iyn3'
  vendredi: 'kd7g'
  samedi: 'lrrx'
  dimanche: 'yevm'

request = new XMLHttpRequest()
request.open('GET', API_URL, true)
request.onload = () ->
  if request.status < 200 || request.status >= 400
    console.error 'Error retreiving data', request
  else
    data = JSON.parse(request.responseText)
    result = []
    for i in [3..12]
      continue if not data.feed.entry[i]['gsx$_cn6ca']?
      
      club_name = data.feed.entry[i]['gsx$_cn6ca']['$t'].replace(' / Faites le mur', '').replace(' 20ème', '')
      result[club_name] = []
  
      for day,key of days
        result[club_name].push data.feed.entry[i]['gsx$_c'+key]?['$t'].replace(' à partir du 7 novembre', '').replace(/\s+/g, '').replace('à', '-').replace('de', '').replace('et', '<br>')
  
    final_table = '<table><thead><tr><th></th><th>' + (Object.keys(days).join '</th><th>') + '</th></tr></thead><tbody>'
  
    for club,times of result
      final_table += '<tr><td class="club">' + club + '</td><td>' + (times.join '</td><td>') + '</td></tr>'

    document.getElementById("grimper-chez-les-voisins").innerHTML = final_table + '</tbody></table>'

request.onerror = () ->
    console.error 'Error retreiving data'

request.send()

css = document.createElement("style")
css.type = "text/css"
css.innerHTML = "table {
      border-collapse: collapse;
      font-size: 0.8em;
      text-align: center;
      }

td, th {
      padding: 10px;
      background: #dcecf5;
      border: 1px solid #bad8eb;
      }

      .club, th {
      background: #fff;
      font-weight: normal;
      font-size: 1.1em;
      }

      .club {
      text-align: left;
      }

      td:empty {
      background: #fff;
      }"
document.body.appendChild(css)
