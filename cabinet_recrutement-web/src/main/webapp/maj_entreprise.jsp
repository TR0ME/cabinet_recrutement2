<%@ page import="eu.telecom_bretagne.cabinet_recrutement.data.model.Entreprise" %><%--
  Created by IntelliJ IDEA.
  User: mathieu
  Date: 27/02/2023
  Time: 09:59
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html" pageEncoding="ISO-8859-1" %>
<%@ page errorPage="/erreur.jsp" %>
<%
    Entreprise ent = (Entreprise) session.getAttribute("utilisateur");
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
        <h4>Mise à jour des informations d'une entrerpise</h4>
        <% if(request.getParameter("submit") !=null){

        } else if (request.getParameter("reset")!=null || request.getParameter("nom")=="" || request.getParameter("descriptif") == "" || request.getParameter("adresse_postale") == "") {

        %>
    <div class="col-lg-offset-2 col-lg-8
                        col-xs-12">
            <form role="form" action="template.jsp" method="get">
                <input type="hidden" name="action" value="nouvelle_entreprise" />
                <div class="form-group">
                    <input class="form-control" placeholder="Nom de l'entreprise" name="nom" />
                </div>
                <div class="form-group">
                    <textarea class="form-control" placeholder="Descriptif de l'entreprise" rows="5" name="descriptif"></textarea>
                </div>
                <div class="form-group">
                    <input class="form-control" placeholder="Adresse postale (ville)" name="adresse_postale" />
                </div>
                <div class="text-center">
                    <button type="submit" class="btn btn-success btn-circle btn-lg" name="submit-insertion"><i class="fa fa-check"></i></button>
                    <button type="reset"  class="btn btn-warning btn-circle btn-lg"><i class="fa fa-times"></i></button>
                </div>
            </form>
        </div>
        <%
            }
        %>

    </div> <!-- /#page-wrapper -->
</div> <!-- /#wrapper -->
<jsp:include page="fragments/fin_de_page.html"/>
</body>
</html>