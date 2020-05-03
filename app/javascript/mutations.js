import gql from 'graphql-tag';

export default {
  requestForUrl: gql`
    mutation request_for_url($url: String!) {
      requestForUrl(input: {url: $url}) {
        request {
          id
          source {
            id
            url
            downloads {
              id
              title
            }
          }
        }
        errors
      }
    }
  `,
  destroyRequest: gql`
    mutation destroy_request($id: Int!) {
      destroyRequest(input: {id: $id}) {
        errors
      }
    }
  `,
};
