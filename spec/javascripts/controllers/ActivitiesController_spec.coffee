describe 'ActivitiesController', ->
  scope        = null
  ctrl         = null
  location     = null
  routeParams  = null
  resource     = null
  httpBackend  = null

  setupController =(date_from, date_to, results)->
    inject(($location, $routeParams, $rootScope, $resource, $httpBackend, $controller)->
      scope       = $rootScope.$new()
      location    = $location
      resource    = $resource
      httpBackend = $httpBackend
      routeParams = $routeParams
      routeParams.date_from = date_from
      routeParams.date_to = date_to

      if date_from and date_to
        request = new RegExp("/api/v1/activities.*date_from=#{date_from}.*date_to=#{date_to}")
      else
        request = new RegExp("/api/v1/activities")

      httpBackend.expectGET(request).respond(results)

      ctrl        = $controller('ActivitiesController',
        $scope: scope
        $location: location)
    )

  beforeEach(module('time_man'))

  afterEach ->
    httpBackend.verifyNoOutstandingExpectation()
    httpBackend.verifyNoOutstandingRequest()

  describe 'controller initialization', ->
    describe 'when no parameters present', ->
      date_from = null
      date_to = null
      activities = [
        {
          id: 1
          name: 'User registration and authentication'
          date: new Date('2015-01-02')
          hours: 1
        },
        {
          id: 2
          name: 'Activity management'
          date: new Date('2015-03-04')
          hours: 2
        },
        {
          id: 3
          name: 'User settings'
          date: new Date('2015-04-05')
          hours: 3
        },
        {
          id: 4
          name: 'Highlighting of under performance'
          date: new Date('2015-06-07')
          hours: 4
        },
        {
          id: 5
          name: 'Roles'
          date: new Date('2015-08-09')
          hours: 5
        }
      ]
      beforeEach ->
        setupController(date_from, date_to, activities)
        httpBackend.flush()

      it 'defaults to all activities', ->
        expect(scope.activities).toEqualData(activities)

    describe 'with parameters', ->
      date_from = '2015-03-04'
      date_to = '2015-04-05'
      activities = [
        {
          id: 2
          name: 'Activity management'
          date: new Date('2015-03-04')
          hours: 2
        },
        {
          id: 3
          name: 'User settings'
          date: new Date('2015-04-05')
          hours: 3
        }
      ]
      beforeEach ->
        setupController(date_from, date_to, activities)
        httpBackend.flush()

      it 'calls the back-end', ->
        expect(scope.activities).toEqualData(activities)

  describe 'search()', ->
    beforeEach ->
      setupController()
      httpBackend.flush()

    it 'redirects to itself with params', ->
      date_from = '2015-03-04'
      date_to = '2015-03-04'
      scope.search(date_from, date_to)
      expect(location.path()).toBe('/')
      expect(location.search()).toEqualData({ date_from: date_from, date_to: date_to })
