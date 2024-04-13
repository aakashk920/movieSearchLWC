public with sharing class MovieSearchController {
    @AuraEnabled(cacheable=true)
    public static List<MovieWrapper> getMovies(String searchTerm) {
        String apiKey = 'a4c72bd6'; // Replace with your actual OMDB API key
        String apiUrl = 'https://www.omdbapi.com/?apikey=' + apiKey + '&s=' + EncodingUtil.urlEncode(searchTerm, 'UTF-8');

        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint(apiUrl);
        request.setMethod('GET');

        HttpResponse response = http.send(request);

        List<MovieWrapper> movies = new List<MovieWrapper>();
        if (response.getStatusCode() == 200) {
            Map<String, Object> responseData = (Map<String, Object>)JSON.deserializeUntyped(response.getBody());
            if (responseData.containsKey('Search')) {
                List<Object> searchResults = (List<Object>)responseData.get('Search');
                for (Object result : searchResults) {
                    Map<String, Object> movieData = (Map<String, Object>)result;
                    movies.add(new MovieWrapper(
                        (String)movieData.get('Title'),
                        (String)movieData.get('Year'),
                        (String)movieData.get('imdbID'),
                        (String)movieData.get('Poster'),
                        (String)movieData.get('Type') // Add writer field
                        // Add more fields as needed
                    ));
                }
            }
        }
        return movies;
    }
    public class MovieWrapper {
        @AuraEnabled
        public String title { get; private set; }
        @AuraEnabled
        public String year { get; private set; }
        @AuraEnabled
        public String imdbID { get; private set; } // Add genre field
        @AuraEnabled
        public String poster { get; private set; }
        @AuraEnabled
        public String Type { get; private set; } // Add writer field

        public MovieWrapper(String title, String year, String imdbID, String poster, String Type) {
            this.title = title;
            this.year = year;
            this.imdbID = imdbID;
            this.poster = poster;
            this.Type = Type;
        }
    }
}
