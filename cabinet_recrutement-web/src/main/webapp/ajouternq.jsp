<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1" %>

<%@page import="eu.telecom_bretagne.cabinet_recrutement.front.utils.ServicesLocator,
                eu.telecom_bretagne.cabinet_recrutement.service.IServiceEntreprise,
                eu.telecom_bretagne.cabinet_recrutement.data.model.Entreprise" %>
<%@ page import="eu.telecom_bretagne.cabinet_recrutement.service.IServiceCandidat" %>
<%@ page import="eu.telecom_bretagne.cabinet_recrutement.data.model.Candidat" %>
<%@ page import="eu.telecom_bretagne.cabinet_recrutement.data.model.NiveauQualification" %>
<%@ page import="eu.telecom_bretagne.cabinet_recrutement.service.IServiceQualification" %>
<%@ page import="java.util.List" %>

<%
    String erreur = null;
    String niv_qualif_form = request.getParameter("niv_qualif_form");
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
                            if (niv_qualif_form == null && session.getAttribute("admin") != null) // Pas de paramètre "niv_qualif_form" => affichage du formulaire
                            {
                        %>
                        <div class="row col-xs-offset-2 col-xs-8">
                            <!-- Formulaire -->
                            <form role="form" action="ajouternq.jsp" method="get">
                                <fieldset>
                                    <div class="form-group">
                                        <input class="form-control" placeholder="niveau de sualification"
                                               name="niv_qualif_form"
                                               type="text" autofocus>
                                    </div>
                                    <button type="submit" class="btn btn-lg btn-success btn-block">Ajouter le niveau de
                                        qualification
                                    </button>
                                </fieldset>
                            </form>
                            <p/>

                        </div>
                        <%
                        } else // Paramètre "niv_qualif_form" existant => connexion
                        {

                            IServiceQualification serviceQualification = null;
                            try {
                                serviceQualification = (IServiceQualification) ServicesLocator.getInstance().getRemoteInterface("ServiceQualification");
                            } catch (Exception e) {
                        %>
                        <p><%
                            e.printStackTrace();
                        %></p>
                        <%
                            }

                            List<NiveauQualification> listNQ = serviceQualification.findAll();

                            for (NiveauQualification niv : listNQ) {
                                if (niv.getIntituleQualification().toLowerCase() == niv_qualif_form) {
                                    erreur = "ERREUR : Le niveau de qualification exite déja !";
                                }
                            }
                            if (erreur == null) {
                                serviceQualification.addNiveauQualification(niv_qualif_form);
                            }

                            // TODO : code spécifique pour la connexion d'un candidat -->
                            else if (niv_qualif_form.equals("")) {
                                erreur = "Veuillez renseignez un niv_qualif_form pour pouvoir l'ajouter";
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
                                            onclick="window.location.href='ajouternq.jsp'">
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
