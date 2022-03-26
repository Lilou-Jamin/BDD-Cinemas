<!DOCTYPE html>
<html lang="fr">
    <!-- En-tête de la page HTML -->
    <head>
        <meta charset="utf-8">
        <title>Création d'un cinéma</title>
    </head>
    <!-- Corps de la page HTML -->
    <body>
        <form action="/ajouteEntree" method="post">
            <h1 style="color: white; font-family : Arial;"> Ajout d'un cinéma</h1>
            <p style="color: white; font-family : Arial;"> Ajoutez dès maintenant votre cinéma en remplissant les champs suivants avec les données correspondantes.</p>
            <label for="nom">Nom : </label><input type="text" name="name" id="name" required>
			<label for="nom">Marque : </label><input type="text" name="marque" id="marque" required>
			<label for="nom">Commune : </label><select id="commune" name="commune">
			% for ligne in lignesLocalisation:
				<option value=" {{ ligne['id_loc']}} "> {{ ligne["com_nom"] }}</option>
			%end
			</select>
			<fieldset><legend>Communication</legend>
				<label>Site web : </label><input type="text" name="website" id="website" >
				<label>Numéro de téléphone : </label><input type="text" name="phone" id="phone" >
				<label>Facebook : </label><input type="text" name="facebook" id="facebook" >
			</fieldset>
			<br />
			<fieldset><legend>Fonctionnalités</legend>
				<label>Accès handicapé : </label><input type="text" name="wheelchair" id="wheelchair" >
				<label>Plein air : </label><input type="text" name="open_air" id="open_air" >
				<label>Cinéma 3D : </label><input type="text" name="cinema3d" id="cinema3d" >
				<br>
				<br>
				<label>Nombre d'écrans : </label><input type="text" name="nb_screens" id="nb_screens" >
				<label>Nombre de places : </label><input type="text" name="capacity" id="capacity" >
				<label>Sous-titres : </label><input type="text" name="acoustic" id="acoustic" >
			</fieldset>
            <br>
			<input type="submit" value="Enregistrer" />
        </form>
		<ul>
            <li><a href="/"style="color : white">Page d'accueil</a></li>
            <li><a href="/liste"style="color : white">Liste des cinémas</a></li>
        </ul>
        <style>
        body {
            background-image: url('https://cdn.wallpapersafari.com/43/47/4KupwZ.jpg');
        }
        </style>
    </body>
</html>
    </body>
</html>
