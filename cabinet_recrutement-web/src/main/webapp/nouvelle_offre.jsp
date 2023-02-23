<%--
  Created by IntelliJ IDEA.
  User: mathieu
  Date: 22/02/2023
  Time: 16:28
  To change this template use File | Settings | File Templates.
--%>
<%@page
        import="eu.telecom_bretagne.cabinet_recrutement.service.IServiceEntreprise" %>
<%@page
        import="eu.telecom_bretagne.cabinet_recrutement.data.model.Entreprise" %>
<%@page
        import="eu.telecom_bretagne.cabinet_recrutement.data.model.OffreEmploi" %>
<%@page
        import="eu.telecom_bretagne.cabinet_recrutement.service.IServiceOffreEmploi" %>
<%@page
        import="eu.telecom_bretagne.cabinet_recrutement.data.model.SecteurActivite" %>
<%@page
        import="eu.telecom_bretagne.cabinet_recrutement.data.model.NiveauQualification" %>
<%@ page language="java" contentType="text/html"
         pageEncoding="ISO-8859-1" %>

<%@page
        import="eu.telecom_bretagne.cabinet_recrutement.front.utils.ServicesLocator,
                eu.telecom_bretagne.cabinet_recrutement.data.model.Candidat,
                java.util.List" %>

<%
    IServiceOffreEmploi serviceOffreEmploi = (IServiceOffreEmploi) ServicesLocator.getInstance().getRemoteInterface("ServiceOffreEmploi");
    IServiceEntreprise serviceEntreprise = (IServiceEntreprise) ServicesLocator.getInstance().getRemoteInterface("ServiceEntreprise");
    List<NiveauQualification> niveauqualif = serviceOffreEmploi.listeNiveauQualification();
    List<SecteurActivite> secteurActs = serviceOffreEmploi.listeSecteurs();
    Object utilisateur = session.getAttribute("utilisateur");
    Entreprise entX = (Entreprise) utilisateur;

    //action/=nouvelle_offre&titre=azdazd&descriptif_mission=azdazd&profil_recherche=azdazdazd&niveau=1&secteur=1&submit-insertion=#
%>

<%
    if (request.getParameter("submit-insertion") != null) {
        if (request.getParameter("titre").length() > 0
                && request.getParameter("descriptif_mission").length() > 0
                && request.getParameter("profil_recherche").length() > 0
                && request.getParameter("niveau").length() > 0
                && request.getParameter("secteur").length() > 0) {

            OffreEmploi of_ok = new OffreEmploi(
                    serviceOffreEmploi.getCurrentDate(),
                    request.getParameter("descriptif_mission"),
                    request.getParameter("profil_recherche"),
                    request.getParameter("titre"),
                    entX,
                    serviceOffreEmploi.findNQByID(Integer.parseInt(request.getParameter("niveau")))
            );

            try {
                of_ok = serviceOffreEmploi.execPersist(of_ok);
                entX.getOffreEmploi().add(of_ok);
                entX = serviceEntreprise.execUpdate(entX);
                serviceOffreEmploi.majSecteursActivites(request.getParameterValues("secteur"), of_ok.getIdOffre());
                entX = serviceEntreprise.getEntreprise(entX.getId());
                session.setAttribute("utilisateur", entX);
                System.out.println("<h1 style=\"color: green;text-align: center\"> offre ajoutée ! </h1>");

            } catch (Exception e) {
                System.out.println("<h1 style=\"color: red;text-align: center\"> Erreur lors de l'ajout  ! </h1>");

            }


        }
    }
%>

<body>
<jsp:include page="fragments/head.html"/>
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
    <!-- base code demo -->
    <div class="row">
        <div class="col-lg-12">
            <div class="panel panel-default">
                <div class="panel-heading">
                    <h3>
                        <i class="glyphicon glyphicon-transfer"></i> Référencer une
                        nouvelle offre d'emploi
                    </h3>
                </div>
                <!-- /.panel-heading -->
                <div class="panel-body">

                    <div
                            class="col-lg-offset-2 col-lg-8
                        col-xs-12">
                        <form role="form" action="template.jsp" method="get">
                            <input type="hidden" name="action" value="nouvelle_offre"/>
                            <div class="form-group">
                                <input class="form-control" placeholder="Titre de l'offre"
                                       name="titre"/>
                            </div>
                            <div class="form-group">
							<textarea class="form-control"
                                      placeholder="Descriptif de la mission" rows="5"
                                      name="descriptif_mission"></textarea>
                            </div>
                            <div class="form-group">
							<textarea class="form-control" placeholder="Profil recherché"
                                      rows="5" name="profil_recherche"></textarea>
                            </div>
                            <div class="col-lg-3">
                                <div class="form-group">
                                    <label>Niveau de qualification</label>
                                    <small><% for (NiveauQualification nq : niveauqualif) {%>

                                        <div class="radio">
                                            <label> <input type="radio" name="niveau"
                                                           value=<%=nq.getIdQualification() %>/><%=nq.getIntituleQualification() %>
                                            </label>
                                        </div>
                                        <%} %>
                                    </small>
                                </div>
                            </div>
                            <div class="col-lg-9">
                                <div class="form-group">
                                    <label>Secteur(s) d'activité</label> <small>
                                    <table border="0" width="100%">
                                        <!-- Un petit système à la volée pour mettre les checkboxes en deux colonnes...  -->
                                        <%
                                            int i = 0;
                                            for (SecteurActivite s : secteurActs) {
                                                i++;
                                                if (i % 2 == 0) {%>

                                        <td><input type="checkbox" name="secteur"
                                                   value=<%=s.getIdSecteur()%>/><%=s.getIntituleActivite()%>
                                        </td>
                                        </tr>
                                        <%} else {%>
                                        <tr>
                                            <td><input type="checkbox" name="secteur"
                                                       value=<%=s.getIdSecteur()%>/><%=s.getIntituleActivite()%>
                                            </td>

                                                <%} %>
                                                <%}
                      		if(i%2==1) System.out.println("</tr>");%>

                                    </table>
                                </small>
                                </div>
                            </div>
                            <div class="text-center">
                                <button type="submit" class="btn btn-success btn-circle btn-lg"
                                        name="submit-insertion">
                                    <i class="fa fa-check"></i>
                                </button>
                                <button type="reset" class="btn btn-warning btn-circle btn-lg">
                                    <i class="fa fa-times"></i>
                                </button>
                            </div>
                        </form>
                    </div>

                </div>
                <!-- /.panel-body -->
            </div>
            <!-- /.panel -->
        </div>
        <!-- /.col-lg-12 -->
    </div>
    <!-- /.row -->
</div>
</body>
