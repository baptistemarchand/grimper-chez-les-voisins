API_URL = "https://spreadsheets.google.com/feeds/list/1Ne8EcecR114npRqZG9SS3435R9BuQguCIasvHMlVI4U/default/public/values?alt=json"

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
request.open('GET', API_URL)
request.onload = () ->
  if request.status < 200 || request.status > 399
    return
  data = JSON.parse(request.responseText).feed.entry
  result = []
  name = 'gsx$_cn6ca'
  for i in [3..12]
    continue if not data[i][name]?

    club_name = data[i][name]['$t'].replace(/ \/ \w+ le mur/, '').replace(' 20ème', '')
    result[club_name] = []

    for day,key of days
      result[club_name].push data[i]['gsx$_c'+key]?['$t'].replace(/ à \w+ du 7 \w+/, '').replace(/\s+/g, '').replace('à', '-').replace('de', '').replace('et', '<br>')

  final_table = '<table><thead><tr><th></th><th>' + (Object.keys(days).join '</th><th>') + '</th></tr></thead><tbody>'

  td = '</td><td>'
  for club,times of result
    final_table += '<tr><td class="club">' + club + td + (times.join td) + '</td></tr>'

  document.getElementById("grimper-chez-les-voisins").innerHTML = final_table + '</tbody></table>'

request.send()

