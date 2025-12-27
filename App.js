import './App.css';
import { BrowserRouter as Router, Route, Routes } from 'react-router-dom';
import 'bootstrap/dist/css/bootstrap.min.css';
import 'bootstrap/dist/js/bootstrap.bundle.min.js';
import './tailwind.css';
import Dashboard from './pages/dashboard';
import Login from './pages/login';
import Register from './pages/register';
import Praktik2 from './pages/praktik2';
import DashboardMonitoring from './pages/dashboard_monitoring';
import Data_PetaniKonsumen from './pages/Data_PetaniKonsumen';
import PraktikBootstrap  from './pages/praktikbootstrap';
import PraktikTailwind from './pages/praktiktailwind';
import AnalisisStatistik from './pages/analisisstatistik';
import PraktikAPI from './pages/praktikAPI';
import Navbar from './pages/navbar';
import Historylogin from './pages/Historylogin';
import AdminLayout from './components/AdminLayout';
import RiwayatLogin from './pages/riwayatlogin';
import ManajemenUser from './pages/manajemenUser';
import DataPetani from './pages/dataPetani';

function App() {
  return (
    <Router>
      <div className="App">
        <Routes>
          <Route path="/dashboard" element={<Dashboard />} />
          <Route path="/login" element={<Login />} />
          <Route path="/register" element={<Register />} />
          <Route path="/praktik2" element={<Praktik2 />} />
          <Route path="/dashboard_monitoring" element={<DashboardMonitoring />} /> 
          <Route path="/data_petanikonsumen" element={<Data_PetaniKonsumen />} /> 
          <Route path="/praktikbootstrap" element={<PraktikBootstrap />} />  
          <Route path="/praktiktailwind" element={<PraktikTailwind />} /> 
          <Route path="/analisisstatistik" element={<AnalisisStatistik />} />     
          <Route path="/praktikAPI" element={<PraktikAPI />} /> 
          <Route path="/navbar" element={<Navbar />} />
          <Route path="/adminlayout" element={<AdminLayout />} />
          <Route path="/historylogin" element={<Historylogin />} /> 
          <Route path="/riwayat_login" element={<RiwayatLogin />} />
          <Route path="/manajemen_user" element={<ManajemenUser />} />  
          <Route path="/data_petani" element={<DataPetani />} />  
        </Routes>
      </div>
    </Router>
  );
}

export default App;
