<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1" %>

<%@page import="eu.telecom_bretagne.cabinet_recrutement.front.utils.ServicesLocator,
                eu.telecom_bretagne.cabinet_recrutement.service.IServiceEntreprise,
                eu.telecom_bretagne.cabinet_recrutement.data.model.Entreprise" %>
<%@ page import="eu.telecom_bretagne.cabinet_recrutement.data.model.Candidat" %>

<div class="navbar-default sidebar" role="navigation">
    <div class="sidebar-nav navbar-collapse">

        <ul class="nav" id="side-menu">

            <!--
              MENU PRINCIPAL
            -->

            <li><a href="index.jsp"><i class="fa fa-home"></i> Accueil</a></li>
            <li>
                <a href="#"><i class="fa fa-th"></i> Gestion des entreprises<span class="fa arrow"></span></a>
                <ul class="nav nav-second-level">
                    <li><a href="template.jsp?action=nouvelle_entreprise">Nouvelle entreprise</a></li>
                    <li><a href="template.jsp?action=liste_entreprises">Liste des entreprises</a></li>
                    <li><a href="template.jsp?action=liste_offres">Liste de toutes les offres d'emploi</a></li>
                </ul> <!-- /.nav-second-level -->
            </li>
            <li>
                <a href="#"><i class="fa fa-users"></i> Gestion des candidatures<span class="fa arrow"></span></a>
                <ul class="nav nav-second-level">
                    <li><a href="template.jsp?action=nouvelle_candidature">Nouvelle candidature</a></li>
                    <li><a href="template.jsp?action=liste_candidatures">Liste des candidatures</a></li>
                </ul> <!-- /.nav-second-level -->
            </li>

            <li><h4></h4></li>
            <%
                //System.out.println(session);
                //System.out.println(session.getAttribute("utilisateur"));
                if (session.getAttribute("utilisateur") != null) {
            %>
            <li>Fonctionnalitr� Candidat</li>
            <li><a href="nouvelle_offre.jsp">Ajouter une offre d'emploi</a></li>
            <li><a href="mon_entreprise.jsp">Mon entreprise</a></li>
            <li><a href="maj_entreprise.jsp">Mettre a jour mes informations</a></li>
            <li><a href="deconnexion.jsp">Se d�connecter</a></li>

            <%
            } else if (session.getAttribute("candidat") != null) {
            %>
            <li><h4>Fonctionnalit� Candidat</h4></li>
            <!--<li><a href="nouvelle_candidature.jsp">Ajouter une candidature</a></li>-->
            <% Candidat cand = (Candidat) session.getAttribute("candidat"); %>
            <li><a href="template.jsp?action=infos_candidature&id=<%=cand.getIdCandidat()%>">Mon profil candidat</a>
            </li>
            <li><a href="template.jsp?action=liste_offres_recommandees">Consulter les offres recommand�es</a></li>
            <li><a href="maj_candidature.jsp">Mise a jour d'une candidature</a></li>
            <li><a href="deconnexion.jsp">Se d�connecter</a></li>
            <%
            } else if (session.getAttribute("admin") != null) {

            %>
            <li><h4>Fonctionnalit� Admin</h4></li>
            <li><a href="ajouternq.jsp">Ajouter des niveau de qualif</a></li>
            <li><a href="ajoutersa.jsp">Ajouter un secteur d'activit�</a></li>
            <li><a href="deconnexion.jsp">Se d�connecter</a></li>
            <%
            } else {

            %>
            <li><a href="connexion.jsp">Connexion</a></li>
            <%
                }
            %>
            <!--
              MENU SECONDAIRE
            -->

            <li><h4>&nbsp;</h4></li>
            <li><a href="http://formations.telecom-bretagne.eu/fip_inf210_fil_rouge/" target="_blank"><i
                    class="fa fa-question-circle"></i> Documentation du fil rouge</a></li>
            <li><a href="http://srv-labs-006.enst-bretagne.fr/CabinetRecrutement_Web/" target="_blank"><i
                    class="fa fa-certificate"></i> D�monstration du prototype</a></li>
            <li><a href="bootstrap/pages/" target="_blank"><i class="fa fa-thumbs-up"></i> D�mo du template SB Admin
                2</a></li>
        </ul>
    </div> <!-- /.sidebar-collapse -->
</div>
<!-- /.navbar-static-side -->
