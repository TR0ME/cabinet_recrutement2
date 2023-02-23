<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1" %>

<%@page import="eu.telecom_bretagne.cabinet_recrutement.front.utils.ServicesLocator,
                eu.telecom_bretagne.cabinet_recrutement.service.IServiceEntreprise,
                eu.telecom_bretagne.cabinet_recrutement.data.model.Entreprise" %>
<%@ page import="eu.telecom_bretagne.cabinet_recrutement.service.IServiceCandidat" %>
<%@ page import="eu.telecom_bretagne.cabinet_recrutement.data.model.Candidat" %>
<%@ page import="eu.telecom_bretagne.cabinet_recrutement.data.model.NiveauQualification" %>
<%@ page import="eu.telecom_bretagne.cabinet_recrutement.service.IServiceQualification" %>
<%@ page import="java.util.List" %>
<%@ page import="eu.telecom_bretagne.cabinet_recrutement.service.IServiceSecteur" %>
<%@ page import="eu.telecom_bretagne.cabinet_recrutement.data.model.SecteurActivite" %>

<%
    String erreur = null;
    String sa_form = request.getParameter("sa_form");
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
        <p style="font-size: 5">&nbsp;</p>
        <div class="row">
            <div class="col-lg-12">
                <div class="panel panel-default">
                    <div class="panel-heading">
                        <h3><i class="fa fa-sign-in"></i> Ajouter un niveau de qualification</h3>
                    </div> <!-- /.panel-heading -->
                    <div class="panel-body">
                        <%
                            if (sa_form == null && session.getAttribute("admin") != null) // Pas de paramètre "sa_form" => affichage du formulaire
                            {
                        %>
                        <div class="row col-xs-offset-2 col-xs-8">
                            <!-- Formulaire -->
                            <form role="form" action="ajoutersa.jsp" method="get">
                                <fieldset>
                                    <div class="form-group">
                                        <input class="form-control" placeholder="niveau de sualification"
                                               name="sa_form"
                                               type="text" autofocus>
                                    </div>
                                    <button type="submit" class="btn btn-lg btn-success btn-block">Ajouter le Secteur d'activité
                                    </button>
                                </fieldset>
                            </form>
                            <p/>

                        </div>
                        <%
                        } else // Paramètre "sa_form" existant => connexion
                        {

                            IServiceSecteur serviceSecteur = null;
                            try {
                                serviceSecteur = (IServiceSecteur) ServicesLocator.getInstance().getRemoteInterface("ServiceSecteur");
                            } catch (Exception e) {
                        %>
                        <p><%
                            e.printStackTrace();
                        %></p>
                        <%
                            }

                            List<SecteurActivite> secteurActivites = serviceSecteur.listeDesSecteurs();

                            for (SecteurActivite secteurActivite : secteurActivites) {
                                if (secteurActivite.getIntituleActivite() == sa_form) {
                                    erreur = "ERREUR : Le niveau de qualification exite déja !";
                                }
                            }
                            if (erreur == null) {
                                SecteurActivite sa = new SecteurActivite(sa_form);
                                serviceSecteur.execPersist(sa);
                            }

                            // TODO : code spécifique pour la connexion d'un candidat -->
                            else if (sa_form.equals("")) {
                                erreur = "Veuillez renseignez un sa_form pour pouvoir l'ajouter";
                            } else {
                                erreur = "Niv qualif non reconnu";
                            }
                            if (erreur == null) {
                                response.sendRedirect("template.jsp");
                            } else {
                        %>
                        <div class="row col-xs-offset-1 col-xs-10">
                            <div class="panel panel-red">
                                <div class="panel-heading ">
                                    Impossible d'ajouter un niveau de qualification'
                                </div>
                                <div class="panel-body text-center">
                                    <p class="text-danger"><strong><%=erreur%>
                                    </strong></p>
                                    <button type="button"
                                            class="btn btn-danger"
                                            onclick="window.location.href='ajoutersa.jsp'">
                                        Retour...
                                    </button>
                                </div>
                            </div>
                        </div> <!-- /.row col-xs-offset-1 col-xs-10 -->
                        <%
                                }
                            }
                        %>
                    </div> <!-- /.panel-body -->
                </div> <!-- /.panel-default -->
            </div> <!-- /.col-lg-12 -->
        </div> <!-- /.row -->
    </div> <!-- /#page-wrapper -->
</div> <!-- /#wrapper -->
<jsp:include page="fragments/fin_de_page.html"/>
</body>
</html>
