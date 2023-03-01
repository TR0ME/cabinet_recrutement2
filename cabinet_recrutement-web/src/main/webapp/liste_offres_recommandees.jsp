<%--
  Created by IntelliJ IDEA.
  User: mathieu
  Date: 15/02/2023
  Time: 15:44
  To change this template use File | Settings | File Templates.
--%>

<%@ page language="java" contentType="text/html" pageEncoding="ISO-8859-1" %>

<%@page import="eu.telecom_bretagne.cabinet_recrutement.front.utils.ServicesLocator,java.util.List" %>
<%@ page import="eu.telecom_bretagne.cabinet_recrutement.service.IServiceOffreEmploi" %>
<%@ page import="eu.telecom_bretagne.cabinet_recrutement.data.model.OffreEmploi" %>
<%@ page import="eu.telecom_bretagne.cabinet_recrutement.data.model.Candidat" %>
<%@ page import="eu.telecom_bretagne.cabinet_recrutement.data.model.SecteurActivite" %>
<%@ page import="java.util.Set" %>
<%@ page import="java.util.ArrayList" %>

<%
    IServiceOffreEmploi serviceOffreEmploi = (IServiceOffreEmploi) ServicesLocator.getInstance().getRemoteInterface("ServiceOffreEmploi");
    List<OffreEmploi> offresEmplois = serviceOffreEmploi.listeOffreEmploi();

    Candidat cand = (Candidat) session.getAttribute("candidat");
    Set<SecteurActivite> lstSA = cand.getSecteurActivites();
    List<SecteurActivite> sectAff = new ArrayList<SecteurActivite>();

    int idNiveauQualificationCandidat = cand.getNiveauQualification().getIdQualification();
    Set<SecteurActivite> setSecteurActiviteCandidat = cand.getSecteurActivites();

    List<OffreEmploi> listeOffreEmploiRecommandees = (List<OffreEmploi>) serviceOffreEmploi.getOffresRecommandees(setSecteurActiviteCandidat, idNiveauQualificationCandidat);
%>

<div class="row">
    <div class="col-lg-12">
        <div class="panel panel-default">
            <div class="panel-heading"><h3><i class="fa fa-th"></i> Liste des offres emploi référencées </h3></div>
            <!-- /.panel-heading -->
            <div class="panel-body">
                <div class="dataTable_wrapper">
                    <table class="table table-striped table-bordered table-hover" id="dataTables-example">
                        <!--
                          Nom des colonnes
                        -->
                        <thead>
                        <tr>
                            <td><label>ID</label></td>
                            <td><label>Titre</label></td>
                            <td><label>Descriptif</label></td>
                            <td><label>Profil recherche</label></td>
                            <td><label>Secteur Activité</label></td>
                        </tr>
                        </thead>
                        <tr>

                                <%for(OffreEmploi offreEmploi : listeOffreEmploiRecommandees){ %>
                        <tr>
                            <td>OE_<%=offreEmploi.getIdOffre()%>
                            </td>
                            <td><%=offreEmploi.getTitre()%>
                            </td>
                            <td><%=offreEmploi.getDescriptif()%>
                            </td>
                            <td><%=offreEmploi.getProfilRecherche()%>
                            </td>
                            <td><%=offreEmploi.getSecteurActivites()%>
                            </td>
                            <td align="center"><a
                                    href="template.jsp?action=infos_offreEmploi&id=<%=offreEmploi.getIdOffre()%>"><i
                                    class="fa fa-eye fa-lg"></i></a></td>
                        </tr>
                        <% } %>
                        </tr>

                        <!--
                          Contenu du tableau
                        -->
                        <tbody>
                        </tbody>
                    </table>
                </div> <!-- /.table-responsive -->
            </div> <!-- /.panel-body -->
        </div> <!-- /.panel -->
    </div> <!-- /.col-lg-12 -->
</div>
<!-- /.row -->
