<!DOCTYPE html>
<html lang="fr">
    <!-- En-tête de la page HTML -->
    <head>
        <meta charset="utf-8">
        <title>Modification d'un cinéma</title>
    </head>
    <!-- Corps de la page HTML -->
    <body>
        <form action="/modifierEntree" method="post">
            <h1 style="color: white; font-family : Arial;">Données du cinéma</h1>
            <!-- Nom -->
			% for ligne in ligneCinema:
				<!-- Id caché -->
				<input type="hidden" id="id_cine" name="id_cine" value = "{{ ligne["id_cine"] }}" />
				<input type="hidden" id="id_com" name="id_com" value = "{{ ligne["id_com"] }}" />
				<input type="hidden" id="id_fonc" name="id_fonc" value = "{{ ligne["id_fonc"] }}" />
				
				<label for="nom">Nom : </label><input type="text" name="name" id="name" value="{{ ligne["name"] }}" required>
				<label for="nom">Marque : </label><input type="text" name="marque" id="marque" value="{{ ligne["marque"] }}" required>
				<label for="nom">Commune : </label>
				<select id="commune" name="commune">
				% for CommuneCinema in CinemaLocalisation:
					<option value=" {{ CommuneCinema['id_loc']}} " selected='selected' > {{ CommuneCinema['com_nom'] }}</option>
				%end
				% for ligneCommune in lignesLocalisation:
					<option value=" {{ ligneCommune['id_loc']}} "  > {{ ligneCommune['com_nom'] }}</option>
				%end
				</select>
				<fieldset><legend>Communication</legend>
					<label>Site web : </label><input type="text" name="website" id="website" value="{{ ligne["website"] }}">
					<label>Numéro de téléphone : </label><input type="text" name="phone" id="phone" value="{{ ligne["phone"] }}">
					<label>Facebook : </label><input type="text" name="facebook" id="facebook" value="{{ ligne["facebook"] }}">
				</fieldset>
				<br />
				<fieldset><legend>Fonctionnalités</legend>
					<label>Accès handicapé : </label><input type="text" name="wheelchair" id="wheelchair" value="{{ ligne["wheelchair"] }}">
					<label>Plein air : </label><input type="text" name="open_air" id="open_air" value="{{ ligne["open_air"] }}">
					<label>Cinéma 3D : </label><input type="text" name="cinema3d" id="cinema3d" value="{{ ligne["cinema3d"] }}">
					<br>
					<br>
					<label>Nombre d'écrans : </label><input type="text" name="nb_screens" id="nb_screens" value="{{ ligne["nb_screens"] }}">
					<label>Nombre de places : </label><input type="text" name="capacity" id="capacity" value="{{ ligne["capacity"] }}">
					<label>Sous-titres : </label><input type="text" name="acoustic" id="acoustic" value="{{ ligne["acoustic"] }}">
				</fieldset>
				<br>
			%end
			<input type="submit" value="Modifier"/>
        </form>
        <style>
        body {
            background-image: url('https://cdn.wallpapersafari.com/43/47/4KupwZ.jpg');
        }
        </style>
		<ul>
            <li><a href="/"style="color : white">Page d'accueil</a></li>
            <li><a href="/liste"style="color : white">Liste des cinémas</a></li>
        </ul>
    </body>
</html>