<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/site.master" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="Admin_Default" %>

<%@ Register Assembly="DevExpress.Web.ASPxScheduler.v17.1, Version=17.1.3.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web.ASPxScheduler" TagPrefix="dxwschs" %>
<%@ Register TagPrefix="cc1" Namespace="DevExpress.XtraScheduler" Assembly="DevExpress.XtraScheduler.v17.1.Core, Version=17.1.3.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    Dashboard
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="body" Runat="Server">
    <form class="form-horizontal" runat="server">
        <div class="col-lg-12">
            <div class="panel panel-midnightblue">
                <div class="panel-body">
                    <dxwschs:ASPxDateNavigator ID="ASPxDateNavigator1" runat="server" ClientIDMode="AutoID" MasterControlID="schScheduler">
                        <Properties Columns="4">
                        </Properties>
                    </dxwschs:ASPxDateNavigator>
                </div>
            </div>
        </div>
        <div class="col-lg-12">
            <div class="panel panel-midnightblue">
                <div class="panel-heading">
                    Booking Schedule
                </div>
                <div class="panel-body">
                    <dxwschs:ASPxScheduler ID="schScheduler" runat="server" Theme="MetropolisBlue"
                        AppointmentDataSourceID="SqlDataSource1" ClientIDMode="AutoID"
                        ActiveViewType="Month" DataMember="" DataSourceID="SqlDataSource1" Start="2018-04-16" ResourceDataSourceID="SqlDataSource1">
                        <Storage>
                            <Appointments AutoRetrieveId="True">
                                <Mappings AllDay="AllDay" AppointmentId="SchedulerID"
                                    Description="Description" End="EndDate" Label="Label" Location="Location"
                                    RecurrenceInfo="RecurrenceInfo" ReminderInfo="ReminderInfo"
                                    ResourceId="ResourceID" Start="StartDate" Status="Status" Subject="Subject" Type="Type" 
                                    OriginalOccurrenceEnd="OriginalOccurrenceEnd" OriginalOccurrenceStart="OriginalOccurrenceStart" 
                                    TimeZoneId="TimeZoneId" />
                                <CustomFieldMappings>
                                    <dxwschs:ASPxAppointmentCustomFieldMapping Member="CustomField" Name="CustomField" />
                                    <dxwschs:ASPxAppointmentCustomFieldMapping Member="ResourceIDs" Name="ResourceIDs" />
                                </CustomFieldMappings>
                            </Appointments>
                        </Storage>
                        <Views>
                            <DayView>
                                <TimeRulers>
                                    <cc1:TimeRuler></cc1:TimeRuler>
                                </TimeRulers>

                                <AppointmentDisplayOptions ColumnPadding-Left="2" ColumnPadding-Right="4"></AppointmentDisplayOptions>
                            </DayView>

                            <WorkWeekView>
                                <TimeRulers>
                                    <cc1:TimeRuler></cc1:TimeRuler>
                                </TimeRulers>

                                <AppointmentDisplayOptions ColumnPadding-Left="2" ColumnPadding-Right="4"></AppointmentDisplayOptions>
                            </WorkWeekView>
                            <WeekView Enabled="false">
                            </WeekView>
                            <FullWeekView Enabled="true">
                                <TimeRulers>
                                    <cc1:TimeRuler></cc1:TimeRuler>
                                </TimeRulers>
                                <AppointmentDisplayOptions ColumnPadding-Left="2" ColumnPadding-Right="4"></AppointmentDisplayOptions>
                            </FullWeekView>
                        </Views>
                    </dxwschs:ASPxScheduler>
                    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:MyCon %>"
                        DeleteCommand="DELETE FROM [Scheduler] WHERE [SchedulerID] = @SchedulerID"
                        InsertCommand="INSERT INTO [Scheduler] ([Type], [StartDate], [EndDate], [AllDay], [Subject], [Location], [OriginalOccurrenceStart], [OriginalOccurrenceEnd],
                        [Description], [Status], [Label], [ResourceID], [ResourceIDs], [ReminderInfo], [RecurrenceInfo], [CustomField], [TimeZoneId])
                        VALUES (@Type, @StartDate, @EndDate, @AllDay, @Subject, @Location, @OriginalOccurrenceStart, @OriginalOccurrenceEnd, @Description, @Status, @Label,
                         @ResourceID, @ResourceIDs, @ReminderInfo, @RecurrenceInfo, @CustomField, @TimeZoneId)"
                        SelectCommand="SELECT * FROM [Scheduler]"
                        UpdateCommand="UPDATE [Scheduler] SET [Type] = @Type, [StartDate] = @StartDate, [EndDate] = @EndDate, 
                        [AllDay] = @AllDay, [Subject] = @Subject, [Location] = @Location, [OriginalOccurrenceStart] = @OriginalOccurrenceStart, [OriginalOccurrenceEnd] = @OriginalOccurrenceEnd, 
                        [Description] = @Description, [Status] = @Status, 
                        [Label] = @Label, [ResourceID] = @ResourceID, [ResourceIDs] = @ResourceIDs, [ReminderInfo] = @ReminderInfo, 
                        [RecurrenceInfo] = @RecurrenceInfo, [CustomField] = @CustomField, [TimeZoneId] = @TimeZoneId  WHERE 
                        [SchedulerID] = @SchedulerID">
                        <DeleteParameters>
                            <asp:Parameter Name="SchedulerID" Type="Int32" />
                        </DeleteParameters>
                        <InsertParameters>
                            <asp:Parameter Name="Type" Type="Int32" />
                            <asp:Parameter DbType="Datetime" Name="StartDate" />
                            <asp:Parameter DbType="Datetime" Name="EndDate" />
                            <asp:Parameter Name="AllDay" Type="Boolean" />
                            <asp:Parameter Name="Subject" Type="String" />
                            <asp:Parameter Name="Location" Type="String" />
                            <asp:Parameter Name="OriginalOccurrenceStart" DbType="Datetime" />
                            <asp:Parameter Name="OriginalOccurrenceEnd" DbType="Datetime" />
                            <asp:Parameter Name="Description" Type="String" />
                            <asp:Parameter Name="Status" Type="Int32" />
                            <asp:Parameter Name="Label" Type="Int32" />
                            <asp:Parameter Name="ResourceID" Type="Int32" />
                            <asp:Parameter Name="ResourceIDs" Type="String" />
                            <asp:Parameter Name="ReminderInfo" Type="String" />
                            <asp:Parameter Name="RecurrenceInfo" Type="String" />
                            <asp:Parameter Name="CustomField" Type="String" />
                            <asp:Parameter Name="TimeZoneId" Type="String" />
                        </InsertParameters>
                        <UpdateParameters>
                            <asp:Parameter Name="Type" Type="Int32" />
                            <asp:Parameter DbType="Datetime" Name="StartDate" />
                            <asp:Parameter DbType="Datetime" Name="EndDate" />
                            <asp:Parameter Name="AllDay" Type="Boolean" />
                            <asp:Parameter Name="Subject" Type="String" />
                            <asp:Parameter Name="Location" Type="String" />
                            <asp:Parameter Name="OriginalOccurrenceStart" DbType="Datetime" />
                            <asp:Parameter Name="OriginalOccurrenceEnd" DbType="Datetime" />
                            <asp:Parameter Name="Description" Type="String" />
                            <asp:Parameter Name="Status" Type="Int32" />
                            <asp:Parameter Name="Label" Type="Int32" />
                            <asp:Parameter Name="ResourceID" Type="Int32" />
                            <asp:Parameter Name="ResourceIDs" Type="String" />
                            <asp:Parameter Name="ReminderInfo" Type="String" />
                            <asp:Parameter Name="RecurrenceInfo" Type="String" />
                            <asp:Parameter Name="CustomField" Type="String" />
                            <asp:Parameter Name="TimeZoneId" Type="String" />
                            <asp:Parameter Name="SchedulerID" Type="Int32" />
                        </UpdateParameters>
                    </asp:SqlDataSource>
                </div>
            </div>
        </div>
    </form>
</asp:Content>

