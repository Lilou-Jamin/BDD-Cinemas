from bottle import route, post, install, template, request, run, redirect
from bottle_sqlite import SQLitePlugin

"""
Connexion à la base de données SQLite
"""
install(SQLitePlugin(dbfile='cinema.db'))

"""
Routes de l'application
"""
# Page d'accueil
@route('/')
def index():
    return template('templates/index.tpl')

# Formulaire d'ajout d'un cinéma
@route('/cinema')
def cinema(db):
    requete = db.execute('SELECT com_nom,id_loc FROM Localisation GROUP BY com_insee ORDER BY com_nom asc;')
    localisation = requete.fetchall() # Liste des localisations
    return template('templates/cinema.tpl',lignesLocalisation = localisation)

# Liste de tous les cinémas
@route('/liste')
def liste(db):
    requete = db.execute('SELECT * FROM Cinema INNER JOIN Localisation ON Cinema.id_loc = Localisation.id_loc INNER JOIN Communication ON Cinema.id_com = Communication.id_com INNER JOIN Fonctionnalite ON Cinema.id_fonc = Fonctionnalite.id_fonc order by name asc;')
    cinema = requete.fetchall() # Liste des cinémas
    return template('templates/liste.tpl', lignesCinema = cinema)

"""
Requêtes de l'application
"""
# Ajout d'un cinéma dans la BDD et affichage de la page d'accueil
@post('/ajouteEntree')
def ajouteEntree(db):
    # On enregistre la table Communication
    website = request.forms.get('website')
    phone = request.forms.get('phone')
    facebook = request.forms.get('facebook')
    db.execute('INSERT INTO Communication (website,phone,facebook) VALUES ("'+website+'","'+phone+'","'+facebook+'")')
    cursor = db.execute('SELECT max(id_com) FROM Communication')
    idcommunication = str(cursor.fetchone()[0])

    # On enregistre la table Fonctionnalité
    wheelchair = request.forms.get('wheelchair')
    open_air = request.forms.get('open_air')
    cinema3d = request.forms.get('cinema3d')
    nb_screens = request.forms.get('nb_screens')
    capacity = request.forms.get('capacity')
    acoustic = request.forms.get('acoustic')
    db.execute('INSERT INTO Fonctionnalite (wheelchair, open_air, cinema3d, nb_screens, capacity, acoustic) VALUES ("'+wheelchair+'","'+open_air+'","'+cinema3d+'","'+nb_screens+'","'+capacity+'","'+acoustic+'")')
    cursor = db.execute('SELECT max(id_fonc) FROM Fonctionnalite')
    idfonctionnalite = str(cursor.fetchone()[0])

    # On exécute la requête SQL permettant d'ajouter le cinéma dans la BDD.
    nom = request.forms.get('name')
    marque = request.forms.get('marque')
    id_loc = request.forms.get('commune')
    db.execute('INSERT INTO Cinema (name, marque, id_com, id_fonc, id_loc) VALUES ("'+nom+'","'+marque+'","'+idcommunication+'","'+idfonctionnalite+'","'+id_loc+'")')
    return redirect('/')

# Suppression d'un cinéma et de ses tables enfants
@route('/supprimerCinema/<idcine>/<idcom>/<idfonc>')
def supprimerCinema(db,idcine,idcom,idfonc):
    #On va tout d'abord supprimer les tables enfants créées
    # Communication et Fonctionnalité
    db.execute('DELETE FROM Fonctionnalite WHERE id_fonc = "'+idfonc+'"')
    db.execute('DELETE FROM Communication WHERE id_com = "'+idcom+'"')
    db.execute('DELETE FROM Cinema WHERE id_cine = "'+idcine+'"')
    return redirect('/liste')

# Formulaire de modification d'un cinema
@route('/modifierCinema/<idcine>/<idloc>')
def modifierCinema(db,idcine,idloc):
    requete = db.execute('SELECT com_nom,id_loc FROM Localisation GROUP BY com_insee ORDER BY com_nom asc;')
    localisation = requete.fetchall() # Liste des localisations

    requete = db.execute('SELECT com_nom,id_loc FROM Localisation WHERE id_loc = "'+idloc+'";')
    localisationCinema = requete.fetchall() # Localisation du cinéma

    requete = db.execute('SELECT * FROM cinema INNER JOIN Localisation ON Cinema.id_loc = Localisation.id_loc INNER JOIN Communication ON Cinema.id_com = Communication.id_com INNER JOIN Fonctionnalite ON Cinema.id_fonc = Fonctionnalite.id_fonc WHERE id_cine = "'+idcine+'" ;')
    cinema = requete.fetchall() # Récupération du cinéma
    return template('templates/cinema_update.tpl', ligneCinema = cinema, lignesLocalisation = localisation,CinemaLocalisation = localisationCinema)

# Modification d'un cinéma
@post('/modifierEntree')
def modifierEntree(db):
    idcom = request.forms.get('id_com')
    idfonc = request.forms.get('id_fonc')

    # On enregistre la table Communication
    website = request.forms.get('website')
    phone = request.forms.get('phone')
    facebook = request.forms.get('facebook')
    db.execute('UPDATE Communication SET website = "'+website+'",phone = "'+phone+'",facebook= "'+facebook+'" WHERE id_com = "'+idcom+'"')

    # On enregistre la table Fonctionnalité
    wheelchair = request.forms.get('wheelchair')
    open_air = request.forms.get('open_air')
    cinema3d = request.forms.get('cinema3d')
    nb_screens = request.forms.get('nb_screens')
    capacity = request.forms.get('capacity')
    acoustic = request.forms.get('acoustic')
    db.execute('UPDATE Fonctionnalite SET wheelchair = "'+wheelchair+'" ,open_air = "'+open_air+'" ,cinema3d = "'+cinema3d+'",nb_screens = "'+nb_screens+'",capacity = "'+capacity+'",acoustic ="'+acoustic+'" WHERE id_fonc = "'+idfonc+'"')

    # Finalement, on update la table principale Cinéma
    nom = request.forms.get('name')
    marque = request.forms.get('marque')
    id_loc = request.forms.get('commune')
    id_cine = request.forms.get('id_cine')
    db.execute('UPDATE Cinema SET name="'+nom+'", marque="'+marque+'",id_loc ="'+id_loc+'" WHERE id_cine = "'+id_cine+'"')
    return redirect('/liste')

"""
On ouvre un serveur en local sur le port 8000
Tapez http://localhost:8000/ dans le navigateur pour accéder au site après avoir exécuté ce programme Python.
"""
if __name__ == "__main__":
    run(reloader = True, debug = True, host = "127.0.0.1", port = 8000)