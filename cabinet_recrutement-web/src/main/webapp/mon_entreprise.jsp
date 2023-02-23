<%@ page import="eu.telecom_bretagne.cabinet_recrutement.data.model.Entreprise" %>
<%@ page import="eu.telecom_bretagne.cabinet_recrutement.front.utils.Utils" %><%--
  Fichier JSP : template.jsp
  ==========================

  1 - Organisation de la pr�sentation des pages
      -----------------------------------------

  Le fichier "template.jsp" est la page principale de l'application Web, c'est un
  gabarit qui sert aux pages normales ainsi qu'� la page d'erreur.
  Les pages sont organis�es de la mani�re suivante :
         +------------------------------------------------+
         | Bandeau                                        |
         +------------------------------------------------+
         | Menu          | Contenu qui varie suivant      |
         | de            | le contexte :                  |
         | l'application |   - nouvelle entreprise ;      |
         |               |   - liste des candidatures ;   |
         |               |   - etc.                       |
         |               |                                |
         +------------------------------------------------+
  Le bandeau, le menu, etc. sont factoris�s au sein de fichiers externes localis�s dans
  le r�pertoire "fragments" (au sein du r�pertoire "WebContent"). Ces diff�rents contenus
  sont int�gr�s dans la page au moyen de la directive JSP :
    <jsp:include page="fragments/contenu_a_inserer.html" />

  2 - Bootstrap
      ---------

  L'affichage Web de l'application utilise un framwork maintenant tr�s r�pendu, Bootstrap,
  voir :
    http://getbootstrap.com/
  Ce framework facilite grandement la mise en page de sites Web et est utilisable avec
  l'int�gralit� des langages utilis�s pour faire du Web dynamique : Java, PHP, Python, etc.

  De nombreux th�mes Bootstrap sont disponibles (libres ou payants). Le th�me utilis�
  pour le projet biblioth�que est le th�me SB Admin 2. Voir :
    https://startbootstrap.com/template-overviews/sb-admin-2/

  Comme tout site Web utilisant le framwork Bootstrap, l'application biblioth�que est dite
  "responsive", son contenu s'adapte automatiquement au type de terminal utilis� : ordinateur,
  tablette, t�l�phone, etc.

  Le th�me SB Admin 2 et les fichiers n�cessaires au framework Bootstrap sont localis�s dans
  le r�pertoire "WebContent/bootstrap". Une d�monstration des diff�rents composants graphiques
  fournis par le th�me SB Admin 2 est consultable en suivant le lien disponible dans le menu :
    http://localhost:8080/CabinetRecrutement_Web/bootstrap/pages/
--%>

<%@ page language="java" contentType="text/html" pageEncoding="ISO-8859-1" %>
<%@ page errorPage="/erreur.jsp" %>
<%
    String action = request.getParameter("action");
    if (action == null || action.equals(""))
        action = "accueil.jsp";
    else
        action = action + ".jsp";
%>

<!DOCTYPE html>
<html lang="en">
<jsp:include page="fragments/head.html"/>
<body>
<div id="wrapper">
    <!-- Navigation -->
    <nav class="navbar
                  navbar-default
                  navbar-static-top"
         role="navigation"
         style="margin-bottom: 0">
        <jsp:include page="fragments/bandeau.jsp"/>
        <jsp:include page="fragments/menu.jsp"/>
    </nav>
    <div id="page-wrapper">
        <%
            Entreprise entreprise = (Entreprise) session.getAttribute("utilisateur");
        %>
        <div class="col-lg-offset-2 col-lg-8
                          col-xs-12">
            <div class="panel panel-success">
                <div class="panel-heading">
                    Mon entreprise
                </div>
                <div class="panel-body">
                    <small>
                        <table class="table">
                            <tbody>
                            <tr class="success">
                                <td><strong>Identifiant (login)</strong></td>
                                <td>ENT_<%=entreprise.getId()%></td>
                            </tr>
                            <tr class="warning">
                                <td><strong>Nom</strong></td>
                                <td><%=entreprise.getNom()%></td>
                            </tr>
                            <tr class="warning">
                                <td><strong>Adresse postale (ville)</strong></td>
                                <td><%=entreprise.getAdressePostale()%></td>
                            </tr>
                            <tr class="warning">
                                <td><strong>Descriptif</strong></td>
                                <td><%=Utils.text2HTML(entreprise.getDescriptif())%></td>
                            </tr>
                            </tbody>
                        </table>
                    </small>
                </div>
            </div>
        </div>
    </div> <!-- /#page-wrapper -->
</div> <!-- /#wrapper -->
<jsp:include page="fragments/fin_de_page.html"/>
</body>
</html>
