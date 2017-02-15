import ReactOnRails from 'react-on-rails';
import HelloWorld from './HelloWorld/components/HelloWorld';
import SampleCard from './SampleCard/components/SampleCard';

// This is how react_on_rails can see the HelloWorld in the browser.
ReactOnRails.register({
  HelloWorld,
  SampleCard
});
