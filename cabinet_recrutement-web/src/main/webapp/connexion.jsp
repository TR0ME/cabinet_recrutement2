<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1" %>

<%@page import="eu.telecom_bretagne.cabinet_recrutement.front.utils.ServicesLocator,
                eu.telecom_bretagne.cabinet_recrutement.service.IServiceEntreprise,
                eu.telecom_bretagne.cabinet_recrutement.data.model.Entreprise" %>
<%@ page import="eu.telecom_bretagne.cabinet_recrutement.service.IServiceCandidat" %>
<%@ page import="eu.telecom_bretagne.cabinet_recrutement.data.model.Candidat" %>

<%
    String erreur = null;
    String identifiant = request.getParameter("identifiant");
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
                        <h3><i class="fa fa-sign-in"></i> Connexion</h3>
                    </div> <!-- /.panel-heading -->
                    <div class="panel-body">
                        <%
                            if (identifiant == null) // Pas de paramètre "identifiant" => affichage du formulaire
                            {

                        %>
                        <div class="row col-xs-offset-2 col-xs-8">
                            <!-- Formulaire -->
                            <form role="form" action="connexion.jsp" method="get">
                                <fieldset>
                                    <div class="form-group">
                                        <input class="form-control" placeholder="Identifiant" name="identifiant"
                                               type="text" autofocus>
                                    </div>
                                    <button type="submit" class="btn btn-lg btn-success btn-block">Login</button>
                                </fieldset>
                            </form>
                            <p/>
                            <!-- Message -->
                            <div class="alert alert-info col-xs-offset-3 col-xs-6">
                                L'identifiant est la clé primaire préfixée de :
                                <ul>
                                    <li>pour une entreprise : <code>ENT_</code> <em>(ENT_12 par exemple)</em></li>
                                    <li>pour une candidature : <code>CAND_</code> <em>(CAND_7 par exemple)</em></li>
                                </ul>
                                <br/>
                                <em>Note : l'identification se fait sans mot de passe.</em>
                            </div>
                        </div>
                        <%
                        } else // Paramètre "identifiant" existant => connexion
                        {
                            if (identifiant.toLowerCase().startsWith("ent_")) {
                                IServiceEntreprise serviceEntreprise = (IServiceEntreprise) ServicesLocator.getInstance().getRemoteInterface("ServiceEntreprise");
                                int id = Integer.parseInt(identifiant.substring(4)); // On enlève le préfixe "ENT_";
                                Entreprise entreprise = serviceEntreprise.getEntreprise(id);
                                if (entreprise != null) {
                                    session.setAttribute("utilisateur", entreprise);
                                } else {
                                    erreur = "Erreur : il n'y a pas d'entreprise avec cet identifiant : " + identifiant.toUpperCase();
                                }
                            } else if (identifiant.toLowerCase().startsWith("cand_")) {
                                IServiceCandidat serviceCandidat = (IServiceCandidat) ServicesLocator.getInstance().getRemoteInterface("ServiceCandidat");
                                int id = Integer.parseInt(identifiant.substring(5));
                                Candidat candidat = serviceCandidat.getCandidat(id);
                                if (candidat != null) {
                                    session.setAttribute("candidat", candidat);
                                } else {
                                    erreur = "Erreur : Il n'y a pas de candidats avec cet identifiant : " + identifiant.toLowerCase();
                                }
                            }else if (identifiant.toLowerCase().startsWith("adm")){
                                session.setAttribute("admin",1);
                            }
                            // TODO : code spécifique pour la connexion d'un candidat -->
                            else if (identifiant.equals("")) {
                                erreur = "Veuillez renseignez un identifiant pour pouvoir vous connecter";
                            } else {
                                erreur = "Identifiant non reconnu : il n'est pas de la forme CAND_XXX ou ENT_XXX";
                            }
                            if (erreur == null) {
                                response.sendRedirect("template.jsp");
                            } else {
                        %>
                        <div class="row col-xs-offset-1 col-xs-10">
                            <div class="panel panel-red">
                                <div class="panel-heading ">
                                    Impossible de se connecter
                                </div>
                                <div class="panel-body text-center">
                                    <p class="text-danger"><strong><%=erreur%>
                                    </strong></p>
                                    <button type="button"
                                            class="btn btn-danger"
                                            onclick="window.location.href='connexion.jsp'">
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
