<%@ page import="eu.telecom_bretagne.cabinet_recrutement.data.model.Entreprise" %>
<%@ page import="eu.telecom_bretagne.cabinet_recrutement.service.IServiceEntreprise" %>
<%@ page import="eu.telecom_bretagne.cabinet_recrutement.front.utils.ServicesLocator" %>
<%@ page import="eu.telecom_bretagne.cabinet_recrutement.front.utils.Utils" %>

<%--
  Created by IntelliJ IDEA.
  User: mathieu
  Date: 27/02/2023
  Time: 09:59
  To change this template use File | Settings | File Templates.
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
        <h4>Mise à jour des informations d'une entrerpise</h4>
        <% Entreprise ent = (Entreprise) session.getAttribute("utilisateur");
        %>
        <% if (request.getParameter("submit") != null) {
            try {
                //Entreprise ent = (Entreprise) session.getAttribute("utilisateur");
                ent.setDescriptif(request.getParameter("descriptif"));
                ent.setNom(request.getParameter("nom"));
                ent.setAdressePostale(request.getParameter("adresse_postale"));
                IServiceEntreprise serviceEntreprise = (IServiceEntreprise) ServicesLocator.getInstance().getRemoteInterface("ServiceEntreprise");
                serviceEntreprise.execUpdate(ent);
                response.sendRedirect("mon_entreprise.jsp");
        %>
        <h4>MAJ OK de </h4>
        <%
        } catch (Exception e) {

        %>

        <h4>Erreur lors de la mise a jour de l'entreprise</h4>

        <%
            }
        } else if (request.getParameter("reset") != null || request.getParameter("nom") == "" || request.getParameter("descriptif") == "" || request.getParameter("adresse_postale") == "") {
            //Entreprise ent = (Entreprise) session.getAttribute("utilisateur");
        %>
        <div class="col-lg-offset-2 col-lg-8
                        col-xs-12">
            <form role="form" action="maj_entreprise.jsp" method="get">
                <input type="hidden" name="ID" value=" <%=ent.getId()%>"/>
                <div class="form-group">
                    <label>ID : <%=ent.getId()%></label>
                </div>
                <div class="form-group">
                    <label>Nom : </label>
                    <input class="form-control" placeholder="Nom de l'entreprise" name="nom"
                           value="<%=ent.getNom()%> "/>
                </div>
                <div class="form-group">
                    <label>Descriptif : </label>
                    <textarea class="form-control" placeholder="Descriptif de l'entreprise" rows="5"
                              name="descriptif"><%=Utils.text2HTML(ent.getDescriptif())%> </textarea>
                </div>
                <div class="form-group">
                    <label>Adresse postale</label>
                    <input class="form-control" placeholder="Adresse postale (ville)" name="adresse_postale"
                           value="<%=ent.getAdressePostale()%>"/>
                </div>
                <div class="text-center">
                    <button type="submit" class="btn btn-success btn-circle btn-lg" name="submit-insertion"><i
                            class="fa fa-check"></i></button>
                    <button type="reset" class="btn btn-warning btn-circle btn-lg"><i class="fa fa-times"></i></button>
                </div>
            </form>
        </div>
        <%
        } else {
            //Entreprise ent = (Entreprise) session.getAttribute("utilisateur");
        %>
        <div class="col-lg-offset-2 col-lg-8
                        col-xs-12">
            <form role="form" action="maj_entreprise.jsp" method="get">
                <input type="hidden" name="ID" value=" <%=ent.getId()%>"/>
                <div class="form-group">
                    <label>ID : <%=ent.getId()%></label>
                </div>
                <div class="form-group">
                    <label>Nom : </label>
                    <input class="form-control" placeholder="Nom de l'entreprise" name="nom"
                           value="<%=ent.getNom()%> "/>
                </div>
                <div class="form-group">
                    <label>Descriptif : </label>
                    <textarea class="form-control" placeholder="Descriptif de l'entreprise" rows="5"
                              name="descriptif"><%=Utils.text2HTML(ent.getDescriptif())%> </textarea>
                </div>
                <div class="form-group">
                    <label>Adresse postale</label>
                    <input class="form-control" placeholder="Adresse postale (ville)" name="adresse_postale"
                           value="<%=ent.getAdressePostale()%>"/>
                </div>
                <div class="text-center">
                    <button type="submit" class="btn btn-success btn-circle btn-lg" name="submit"><i
                            class="fa fa-check"></i></button>
                    <button type="reset" class="btn btn-warning btn-circle btn-lg"><i class="fa fa-times"></i></button>
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