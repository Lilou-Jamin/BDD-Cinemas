<!DOCTYPE html>
<html lang="fr">
    <!-- En-tête de la page HTML -->
    <head>
        <meta charset="utf-8">
        <title>Liste des cinémas</title>
    </head>
    <!-- Corps de la page HTML -->
    <body>
        <ul>
            <li><a href="/"style="color : white">Page d'accueil</a></li>
            <li><a href="/cinema"style="color : white">Ajouter un cinéma</a></li>
        </ul>
        <table>
            <tr>
                <th>Nom du cinéma</th>
                <th>Marque</th>
                <th>Ville</th>
                <th>Actions</th>
            </tr>
        % for ligneCine in lignesCinema:
            <tr>
                <td style="background-color:Tomato;">{{ ligneCine["name"] }}</td>
                <td style="background-color:Tomato;">{{ ligneCine["marque"] }}</td>
                <td style="background-color:Tomato;">{{ ligneCine["com_insee"] }} {{ ligneCine["com_nom"] }}</td>
                <td>
                <a href="/modifierCinema/{{ ligneCine["id_cine"] }}/{{ ligneCine["id_loc"] }}">Modifier</a> | 
                <a href="/supprimerCinema/{{ ligneCine["id_cine"] }}/{{ ligneCine["id_com"] }}/{{ ligneCine["id_fonc"] }}">Supprimer</a>
                </td>
            </tr>
        % end
        </table>
        <style>
        body {
            background-image: url('https://cdn.wallpapersafari.com/43/47/4KupwZ.jpg');
        }
        </style>'
    </body>
</html>