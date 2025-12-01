def traiter_fichier(df):
    """
    df : DataFrame issu du fichier uploadé
    Retourne : (resultats, non_trouves, accessoire) en DataFrames
    """
    # Ici vous mettez votre logique actuelle
    # Exemple minimal :
    resultats = df[df["simila"] > 0.25]
    non_trouves = df[df["simila"] <= 0.25]
    accessoire = df.head(5)  # à adapter
    return resultats, non_trouves, accessoire