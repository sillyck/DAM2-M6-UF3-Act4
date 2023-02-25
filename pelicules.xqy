<html>
  <head>
    <title>Peliculas</title>
  </head>
  <body>
    <table border="1">
      {
        for $gen in distinct-values(doc("Peliculas2017.xml")//genero)

        let $n_abans := count(doc("Peliculas2017.xml")//peliculas/pelicula[generos/genero=$gen][fecha<2000])
        let $n_despr := count(doc("Peliculas2017.xml")//peliculas/pelicula[generos/genero=$gen][fecha>=2000])
		
		let $duracio_mitja_abans := format-number(avg(doc("Peliculas2017.xml")//peliculas/pelicula[generos/genero=$gen][fecha<2000]/duracion), '999')
		let $duracio_mitja_despres := format-number(avg(doc("Peliculas2017.xml")//peliculas/pelicula[generos/genero=$gen][fecha>=2000]/duracion), '999')
		
		let $otros_generos_abans := avg(count(doc("Peliculas2017.xml")//peliculas/pelicula[generos/genero!=$gen][fecha<2000]//genero))
		let $otros_generos_despres := avg(count(doc("Peliculas2017.xml")//peliculas/pelicula[generos/genero!=$gen][fecha<2000]//genero))
		
		let $min_abans_2000 := min(doc("Peliculas2017.xml")//peliculas/pelicula[generos/genero=$gen]/fecha[text()<2000])
		let $max_abans_2000 := max(doc("Peliculas2017.xml")//peliculas/pelicula[generos/genero=$gen]/fecha[text()<2000])
		
		let $min_despres_2000 := min(doc("Peliculas2017.xml")//peliculas/pelicula[generos/genero=$gen]/fecha[text()>=2000])
		let $max_despres_2000 := max(doc("Peliculas2017.xml")//peliculas/pelicula[generos/genero=$gen]/fecha[text()>=2000])
		
		let $nom_peli_min_abans_2000 := doc("Peliculas2017.xml")//peliculas/pelicula[fecha=$min_abans_2000][1]/titulo
		let $nom_peli_max_abans_2000 := doc("Peliculas2017.xml")//peliculas/pelicula[fecha=$max_abans_2000][1]/titulo
		
		let $nom_peli_min_despres_2000 := doc("Peliculas2017.xml")//peliculas/pelicula[fecha=$min_despres_2000][1]/titulo
		let $nom_peli_max_despres_2000 := doc("Peliculas2017.xml")//peliculas/pelicula[fecha=$max_despres_2000][1]/titulo
		
		let $actors_mitja_abans := format-number(avg(count(doc("Peliculas2017.xml")//peliculas/pelicula[titulo=$nom_peli_min_abans_2000]/actores/actor) + count(doc("Peliculas2017.xml")//peliculas/pelicula[titulo=$nom_peli_max_abans_2000]/actores/actor)), '9.9')
		let $actors_mitja_despres := format-number(avg(count(doc("Peliculas2017.xml")//peliculas/pelicula[titulo=$nom_peli_min_despres_2000]/actores/actor) + count(doc("Peliculas2017.xml")//peliculas/pelicula[titulo=$nom_peli_max_despres_2000]/actores/actor)), '9.9')
		
        where($n_abans>2) and ($n_despr>2)
        order by $gen
        return
        <abc>
			<tr>
				<td colspan="4"><b><center>{data($gen)}</center></b></td>
			</tr>
			<tr>
				<td colspan="2"><center>{$min_abans_2000} - {$max_abans_2000}</center></td>
				<td colspan="2"><center>{$min_despres_2000} - {$max_despres_2000}</center></td>
			</tr>
			<tr>
				<td colspan="2">
					<ul>
						<li>{$nom_peli_min_abans_2000} ({$min_abans_2000})</li>
						<li>{$nom_peli_max_abans_2000} ({$max_abans_2000})</li>
					</ul>
				</td>
				<td colspan="2">
					<ul>
						<li>{$nom_peli_min_despres_2000} ({$min_despres_2000})</li>
						<li>{$nom_peli_max_despres_2000} ({$max_despres_2000})</li>
					</ul>
				</td>
			</tr>
			<tr>
				<td># Peliculas :</td>
				<td>{$n_abans}</td>
				<td># Peliculas :</td>
				<td>{$n_despr}</td>
			</tr>
			<tr>
				<td># Duracion Media</td>
				<td>{$duracio_mitja_abans}</td>
				<td># Duracion Media</td>
				<td>{$duracio_mitja_despres}</td>
			</tr>
			<tr>
				<td># Actores Media :</td>
				<td>{$actors_mitja_abans}</td>
				<td># Actores Media :</td>
				<td>{$actors_mitja_despres}</td>
			</tr>
			<tr>
				<td># Otros Generos Media :</td>
				<td>{$otros_generos_abans}</td>
				<td># Otros Generos Media :</td>
				<td>{$otros_generos_despres}</td>
			</tr>
			
        </abc>
      }
    </table>
  </body>
</html>